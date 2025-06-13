trigger AccountAddressTrigger on Account(before insert, before update ){
    Integer batchSize = 50;
    TriggerControlSettings__c controlSettings = TriggerControlSettings__c.getOrgDefaults();
    if (controlSettings != null && controlSettings.IsTriggerEnabled__c){
        for (Account acc : Trigger.new.subList(0, Math.min(batchSize, Trigger.new.size()))){
            if (acc.Match_Billing_Address__c == true && acc.BillingPostalCode != null){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
}