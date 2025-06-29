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
    static void testCreateCase(){

        ID thisCaseId = CaseManager.createCase('Ferocious chipmunk', 'New', 'Phone', 'Low');

        Assert.isTrue(thisCaseId != null);
        Case thisCase = [SELECT Id, Subject
                         FROM Case
                         WHERE Id = :thisCaseId];
        Assert.isTrue(thisCase != null);
        Assert.areEqual(thisCase.Subject, 'Ferocious chipmunk');
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
    static void testUpsertCase(){

        ID case1Id = CaseManager.upsertCase('Ferocious chipmunk', 'New', 'Phone', 'Low', null);

        Assert.isTrue(Case1Id != null);
        Case case1 = [SELECT Id, Subject
                      FROM Case
                      WHERE Id = :case1Id];
        Assert.isTrue(case1 != null);
        Assert.areEqual(case1.Subject, 'Ferocious chipmunk');

        ID case2Id = CaseManager.upsertCase('Ferocious chipmunk', 'Working', 'Phone', 'Low', case1Id);

        Assert.areEqual(case1Id, case2Id);
        Case case2 = [SELECT Id, Status
                      FROM Case
                      WHERE Id = :case2Id];
        Assert.isTrue(case2 != null);
        Assert.areEqual(case2.Status, 'Working');
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