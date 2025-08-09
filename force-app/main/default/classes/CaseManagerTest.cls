@IsTest
private class CaseManagerTest{
    @isTest
    static void testGetCaseById(){
        Id recordId = createTestRecord();

        RestRequest request = new RestRequest();
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        request.requestUri = baseUrl + '/services/apexrest/Cases/' + 
                   recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Case thisCase = CaseManager.getCaseById();

        Assert.isTrue(thisCase != null);
        Assert.areEqual('Test record', thisCase.Subject);
    }

    @isTest
    static void testDeleteCase(){
        Id recordId = createTestRecord();

        RestRequest request = new RestRequest();
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        request.requestUri = baseUrl + '/services/apexrest/Cases/' + 
                   recordId;
        request.httpMethod = 'DELETE';
        RestContext.request = request;

        CaseManager.deleteCase();

        List<Case> cases = [SELECT Id
                            FROM Case
                            WHERE Id = :recordId];
        Assert.isTrue(cases.size() == 0);
    }

    @isTest
    static void testUpdateCaseFields(){
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        request.requestUri = baseUrl + '/services/apexrest/Cases/' + 
                   recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;

        ID thisCaseId = CaseManager.updateCaseFields();

        Assert.isTrue(thisCaseId != null);
        Case thisCase = [SELECT Id, Status
                         FROM Case
                         WHERE Id = :thisCaseId];
        Assert.isTrue(thisCase != null);
        Assert.areEqual(thisCase.Status, 'Working');
    }

    static Id createTestRecord(){

        Case caseTest = new Case(
            Subject = 'Test record', 
            Status = 'New', 
            Origin = 'Phone', 
            Priority = 'Medium'
        );
        insert caseTest;
        return caseTest.Id;
    }

}