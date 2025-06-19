trigger EmployeeAfterInsertTrigger on Employee__c (after insert) {
    if (!EmployeeTriggerHelper.isAlreadyProcessed) {
        EmployeeTriggerHelper.isAlreadyProcessed = true;
        ServiceRequestProcessor.logVisibleRecords(Trigger.new[0].Id);
    }

    //Database.executeBatch(new Batch(Trigger.newMap.keySet()), 10);
}