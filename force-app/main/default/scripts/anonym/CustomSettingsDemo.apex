List<CountryPhoneCodes__c> phoneCodesAll = CountryPhoneCodes__c.getAll().values();
CountryPhoneCodes__c phoneCodesInstance = CountryPhoneCodes__c.getInstance('USA');
List<CountryPhoneCodes__c> phoneCodesSOQL = [SELECT Id, Name, Phone_Codes__c
                                             FROM CountryPhoneCodes__c];
for (CountryPhoneCodes__c phoneCode : phoneCodesAll){
    System.debug(phoneCode);
}
System.debug('---------------------------------------');
System.debug(phoneCodesInstance);
System.debug('---------------------------------------');
for (CountryPhoneCodes__c phoneCode : phoneCodesSOQL){
    System.debug(phoneCode);
}