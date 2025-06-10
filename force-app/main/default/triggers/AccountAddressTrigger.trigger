trigger AccountAddressTrigger on Account(before insert, before update ){

    TriggerControlSettings__c controlSettings = TriggerControlSettings__c.getOrgDefaults();
    if (controlSettings != null && controlSettings.IsTriggerEnabled__c){
        for (Account acc : Trigger.new ){
            if (acc.Match_Billing_Address__c == true && acc.BillingPostalCode != null){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }

        }
    }
}