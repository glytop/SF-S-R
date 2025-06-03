public class AccountService{
    public static void countContacts(List<Id> accountIds){
        if (accountIds == null || accountIds.isEmpty()){
            return;
        }

        List<AggregateResult> contactCounts = [SELECT AccountId, COUNT(Id)contactCount
                                               FROM Contact
                                               WHERE AccountId IN:accountIds
                                               GROUP BY AccountId];

        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult ar : contactCounts){
            Id accountId = (Id) ar.get('AccountId');
            Integer count = (Integer) ar.get('contactCount');

            accountsToUpdate.add(new Account(
                Id = accountId, 
                NumberOfEmployees = count
            ));
        }

        if (!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }

    public static void updateAnnualRevenue(List<Id> accountIds){
        if (accountIds == null || accountIds.isEmpty()){
            return;
        }

        List<AggregateResult> oppAmounts = [SELECT AccountId, SUM(Amount)totalAmount
                                            FROM Opportunity
                                            WHERE AccountId IN:accountIds AND StageName = 'Closed Won' AND Amount != null
                                            GROUP BY AccountId];

        List<Account> accountsToUpdate = new List<Account>();
        for (AggregateResult ar : oppAmounts){
            Id accountId = (Id) ar.get('AccountId');
            Decimal totalAmount = (Decimal) ar.get('totalAmount');

            accountsToUpdate.add(new Account(
                Id = accountId, 
                AnnualRevenue = totalAmount
            ));
        }

        if (!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }

}