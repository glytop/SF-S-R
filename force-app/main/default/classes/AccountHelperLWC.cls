public with sharing class AccountHelperLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(Id accId){
        try {
            return [SELECT Name, Phone FROM Account WHERE Id = :accId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}