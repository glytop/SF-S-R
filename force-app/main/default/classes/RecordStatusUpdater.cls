public with sharing class RecordStatusUpdater {
    @AuraEnabled
    public static void updateStatus(Id recordId) {
        Lead led = [SELECT Id, Description FROM Lead WHERE Id = :recordId LIMIT 1];
        led.Description = 'Success';
        update led;
    }
}
