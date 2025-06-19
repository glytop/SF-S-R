public with sharing class CustomerSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        return [
            SELECT Id, Name, Phone
            FROM Account
            WHERE Name LIKE :('%' + searchKey + '%')
            ORDER BY Name
            LIMIT 10
        ];
    }
}
