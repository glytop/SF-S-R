public with sharing class ContactUpdaterController {
    @AuraEnabled(cacheable=true)
    public static Contact getContact(String recordId) {
        return [SELECT Id, Email, Phone FROM Contact WHERE Id = :recordId LIMIT 1];
    }

    @AuraEnabled
    public static void updateContact(Contact contactToUpdate) {
        update contactToUpdate;
    }
}