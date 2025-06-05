Account acc = new Account(
    Name = 'Test Account'
);
insert acc;
Contact con1 = new Contact(
    LastName = 'Contact 1', 
    AccountId = acc.Id
);
Contact con2 = new Contact(
    LastName = 'Contact 2', 
    AccountId = acc.Id
);
insert new List<Contact>{
    con1, con2
}
;
AccountService.countContacts(new List<Id>{
    acc.Id
}
);
Account updatedAcc = [SELECT NumberOfEmployees
                      FROM Account
                      WHERE Id = :acc.Id];
System.debug(updatedAcc.NumberOfEmployees);
Opportunity opp = new Opportunity(
    Name = 'Big Deal', 
    StageName = 'Closed Won', 
    CloseDate = Date.today(), 
    Amount = 100000, 
    AccountId = acc.Id
);
insert opp;
AccountService.updateAnnualRevenue(new List<Id>{
    acc.Id
}
);
updatedAcc = [SELECT AnnualRevenue
              FROM Account
              WHERE Id = :acc.Id];
System.debug(updatedAcc.AnnualRevenue);