List<Country_Codes__mdt> codes = [SELECT Label, Phone_code__c FROM Country_Codes__mdt];
for (Country_Codes__mdt code : codes){
    System.debug(code);
}

List<Account> accIds = [SELECT Id FROM Account];