public with sharing class ServiceRequestProcessor {
    public static void logVisibleRecords(Id employeeId) {
        Employee__c emp = [SELECT Id, Description__c FROM Employee__c WHERE Id = :employeeId];
        
        List<Employee__c> visibleWithSharing = [SELECT Id, Name FROM Employee__c];
        String withSharingLog = '\nWith Sharing visible: ' + visibleWithSharing.size() + ' records - ' + JSON.serialize(visibleWithSharing);
        
        List<Employee__c> visibleInherited = InheretedSharing.getVisibleRecords();
        String inheritedLog = '\nInherited (called from with sharing): ' + visibleInherited.size() + ' records - ' + JSON.serialize(visibleInherited);
        
        emp.Description__c = (emp.Description__c == null ? '' : emp.Description__c) + withSharingLog + inheritedLog;
        update emp;
    }
}