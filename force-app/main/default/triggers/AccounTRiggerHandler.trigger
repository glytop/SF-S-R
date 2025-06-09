trigger AccounTRiggerHandler on Account (after update) {
	List<Id> accountId = new List<Id>();
    for (Account acc : Trigger.new){
        Account oldAcc = Trigger.oldMap.get(acc.Id);
        if (acc.Phone != oldAcc.Phone){
            accountId.add(acc.Id);
        }
    }
    
    futureApex.futureCallout(accountId);
}