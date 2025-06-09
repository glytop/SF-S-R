@IsTest
private class AccountManagerTest {
    @isTest static void testGetAccount(){
        Id recordId = createTestRecord();
        
        RestRequest request = new RestRequest();
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        request.requestUri = baseUrl + '/services/apexrest/Accounts/' + recordId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Account thisAccount = AccountManager.getAccount();
        
        System.assert(thisAccount != null);
        System.assertEquals('Test RecordV1', thisAccount.Name);
        
    }
    
    static Id createTestRecord(){
        Account acc = new Account(Name = 'Test RecordV1');
        insert acc;
        return acc.Id;
    }
}