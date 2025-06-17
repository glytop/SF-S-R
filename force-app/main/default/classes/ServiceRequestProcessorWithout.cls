public without sharing class ServiceRequestProcessorWithout {
    public static void logVisibleRecords(Id employeeId) {
        Employee__c emp = [SELECT Id, Description__c FROM Employee__c WHERE Id = :employeeId];
        
        List<Employee__c> visibleWithoutSharing = [SELECT Id, Name FROM Employee__c];
        String withoutSharingLog = '\nWithout Sharing visible: ' + visibleWithoutSharing.size() + ' records - ' + JSON.serialize(visibleWithoutSharing);
        
        List<Employee__c> visibleInherited = InheretedSharing.getVisibleRecords();
        String inheritedLog = '\nInherited (called from without sharing): ' + visibleInherited.size() + ' records - ' + JSON.serialize(visibleInherited);
        
        emp.Description__c = (emp.Description__c == null ? '' : emp.Description__c) + withoutSharingLog + inheritedLog;
        update emp;
    }
}