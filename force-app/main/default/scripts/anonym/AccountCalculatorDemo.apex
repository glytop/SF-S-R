List<Account> accList = [SELECT Id FROM Account LIMIT 5];
List<Id> accIds = new List<Id>();

for (Account acc : accList){
    accIds.add(acc.Id);
}

AccountCalculator.countContacts(accIds);