/**
 * @description       : 
 * @author            : Maksimilian Ramanets
 * @group             : 
 * @last modified on  : 06-13-2025
 * @last modified by  : Maksimilian Ramanets
**/
public class UpdateContactMailingAddress implements Database.Batchable<sObject>, Database.Stateful {
    
    public Integer recordCount = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode,' + 
            '(SELECT Id, MailingStreet, MailingCity, MailingPostalCode FROM Contacts)' +
            'FROM Account WHERE BillingCity = \'New York\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for (Account acc : accList){
            for (Contact con : acc.Contacts){
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                con.MailingPostalCode = acc.BillingPostalCode;
                conList.add(con);
                recordCount++;
            }
        }
        update conList;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Record count: ' + recordCount);
    }
}