List<Account> listAccounts = DatabaseDemos.fetchAccounts();
List<Account> listAccountsLimited = DatabaseDemos.fetchLimitedAccounts(5);
List<Account> listAccountsOffset = DatabaseDemos.fetchOffsetAccounts(10, 3);
List<Account> listAccountsOrderBy = DatabaseDemos.fetchOrderedAccounts('Name');
DatabaseDemos.accountDetails(listAccountsLimited);
DatabaseDemos.accountDetails(listAccountsOffset);
DatabaseDemos.accountDetails(listAccountsOrderBy);