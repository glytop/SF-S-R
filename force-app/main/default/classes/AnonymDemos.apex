/*List<Account> listAccounts = DatabaseDemos.fetchAccounts();
List<Account> listAccountsLimited = DatabaseDemos.fetchLimitedAccounts(5);
List<Account> listAccountsOffset = DatabaseDemos.fetchOffsetAccounts(10, 3);
List<Account> listAccountsOrderBy = DatabaseDemos.fetchOrderedAccounts('Name');
DatabaseDemos.accountDetails(listAccountsLimited);
DatabaseDemos.accountDetails(listAccountsOffset);
DatabaseDemos.accountDetails(listAccountsOrderBy);*/

/*List<List<SObject>> searchList = [FIND 'Cloud' IN ALL FIELDS RETURNING Account(Name), Contact(FirstName,LastName, Email, Department)];
List<Account> accList = new List<Account>();
List<Contact> conList = new List<Contact>();

accList = (List<Account>) searchList[0];
conList = (List<Contact>) searchList[1];

for (Account acc : accList) {
    System.debug('[Account] - ' + acc.Name);
}

for (Contact con : conList) {
    System.debug('[Contact] - ' + con.FirstName + ' ' + con.LastName + ' ' + con.Email + ' ' + con.Department);
}
*/
/*
Account acc = new Account(Name = 'Test Account');
insert acc;

Contact con1 = new Contact(LastName = 'Contact 1', AccountId = acc.Id);
Contact con2 = new Contact(LastName = 'Contact 2', AccountId = acc.Id);
insert new List<Contact>{con1, con2};

AccountService.countContacts(new List<Id>{acc.Id});

Account updatedAcc = [SELECT NumberOfEmployees FROM Account WHERE Id = :acc.Id];
System.debug(updatedAcc.NumberOfEmployees);

Opportunity opp = new Opportunity(
    Name = 'Big Deal',
    StageName = 'Closed Won',
    CloseDate = Date.today(),
    Amount = 100000,
    AccountId = acc.Id
);
insert opp;

AccountService.updateAnnualRevenue(new List<Id>{acc.Id});

updatedAcc = [SELECT AnnualRevenue FROM Account WHERE Id = :acc.Id];
System.debug(updatedAcc.AnnualRevenue);
*/

Opportunity opp1 = new Opportunity(
    Name = 'Test Opp 1',
    StageName = 'Prospecting',
    CloseDate = Date.today(),
    Amount = 50000
);

Opportunity opp2 = new Opportunity(
    Name = 'Test Opp 2',
    StageName = 'Prospecting',
    CloseDate = Date.today().addMonths(1),
    Amount = 60000
);

Opportunity opp3 = new Opportunity(
    Name = 'Big Opp',
    StageName = 'Prospecting',
    CloseDate = Date.today(),
    Amount = 150000
);

insert new List<Opportunity>{opp1, opp2, opp3};

Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];

opp1.Pricebook2Id = standardPricebook.Id;
opp2.Pricebook2Id = standardPricebook.Id;
opp3.Pricebook2Id = standardPricebook.Id;

update new List<Opportunity>{opp1, opp2, opp3};

List<Opportunity> oppsToUpdate = [SELECT Id, Amount, CloseDate FROM Opportunity WHERE Id IN :new List<Id>{opp1.Id, opp2.Id, opp3.Id}];
OpportunityService.applyDiscount(oppsToUpdate, 0.2);
update oppsToUpdate;

OpportunityService.addDefaultProduct(new List<Id>{opp1.Id, opp2.Id, opp3.Id});

for (Opportunity opp : [
    SELECT Id, Amount, CloseDate, 
           (SELECT Id FROM OpportunityLineItems) 
    FROM Opportunity 
    WHERE Id IN :new List<Id>{opp1.Id, opp2.Id, opp3.Id}
]) {
    System.debug('Opportunity ' + opp.Id + ': Amount = ' + opp.Amount + ', CloseDate = ' + opp.CloseDate + ', Products = ' + opp.OpportunityLineItems.size());
}
