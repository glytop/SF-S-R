public class DatabaseDemos {    
    public static List<Account> fetchAccounts(){
        return [SELECT id, name, phone, website FROM Account];
    }

    public static List<Account> fetchLimitedAccounts(Integer limitCount) {
        return [SELECT Id, Name, Phone, Website FROM Account LIMIT :limitCount];
    }

    public static List<Account> fetchOffsetAccounts(Integer offsetCount, Integer limitCount) {
        return [SELECT Id, Name, Phone, Website FROM Account LIMIT :limitCount OFFSET :offsetCount];
    }

    public static List<Account> fetchOrderedAccounts(String orderField) {
        String query = 'SELECT Id, Name, Phone, Website FROM Account ORDER BY ' + orderField;
        return Database.query(query);
    }

    public static void accountDetails(List<Account> listAccounts){
        for (Account acc : listAccounts){
            String accountDetail = '';
            accountDetail += 'Id:' + acc.Id;
            accountDetail += '; Name:' + acc.Name;
            accountDetail += '; Phone:' + acc.Phone;
            accountDetail += '; Website:' + acc.Website;
            system.debug('Account Details: ' + accountDetail);
        }
    }
}