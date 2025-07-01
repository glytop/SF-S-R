public with sharing class AccountContactController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name FROM Account WHERE CreatedBy.Profile.Name != 'Salesforce Platform' ORDER BY CreatedDate DESC];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId(Id accountId){
        return [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId = :accountId];
    }
}