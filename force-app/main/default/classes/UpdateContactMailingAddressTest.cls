/**
 * @description       : 
 * @author            : Maksimilian Ramanets
 * @group             : 
 * @last modified on  : 06-13-2025
 * @last modified by  : Maksimilian Ramanets
**/
@isTest
public class UpdateContactMailingAddressTest{
    @isTest
    public static void AddressCopy(){
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();

        for (Integer i = 1; i <= 5; i++){
            Account acc = new Account(
                Name = 'Test' + i, 
                BillingCity = 'New York', 
                BillingCountry = 'USA'
            );
            accList.add(acc);
        }
        insert accList;

        for (Account acc : accList){
            Contact con = new Contact();
            con.LastName = 'testV8';
            con.AccountId = acc.Id;
            conList.add(con);
        }

        insert conList;

        Test.startTest();

        UpdateContactMailingAddress conUpd = new UpdateContactMailingAddress();
        Id batchId = Database.executeBatch(conUpd);

        Test.stopTest();

        Integer countedContact = [SELECT COUNT() FROM Contact WHERE MailingCity = 'New York'];

        System.assertEquals(5, countedContact);
    }

}