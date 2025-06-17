public inherited sharing class InheretedSharing {
    public static List<Employee__c> getVisibleRecords() {
        return [SELECT Id, Name FROM Employee__c];
    }
}