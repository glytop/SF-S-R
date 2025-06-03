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
