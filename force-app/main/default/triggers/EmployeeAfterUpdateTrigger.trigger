trigger EmployeeAfterUpdateTrigger on Employee__c (after update) {
    if (!EmployeeTriggerHelper.isAlreadyProcessed) {
        EmployeeTriggerHelper.isAlreadyProcessed = true;
        ServiceRequestProcessorWithout.logVisibleRecords(Trigger.new[0].Id);
    }
}