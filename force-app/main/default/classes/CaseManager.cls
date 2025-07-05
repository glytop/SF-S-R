@RestResource(urlMapping = '/Cases/*')
global with sharing class CaseManager{
    @HttpGet
    global static Case getCaseById(){
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case result = [SELECT CaseNumber, Subject, Status, Origin, Priority
                       FROM Case
                       WHERE Id = :caseId];
        return result;
    }

    @HttpPost
    global static ID createCase(){
        Case thisCase = (Case) JSON.deserialize(RestContext.request.requestBody.toString(), Case.class);
        insert thisCase;
        return thisCase.Id;
    }

    @HttpDelete
    global static void deleteCase(){
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case thisCase = [SELECT Id
                         FROM Case
                         WHERE Id = :caseId];
        delete thisCase;
    }

    @HttpPut
    global static ID upsertCase(){
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case thisCase = (Case) JSON.deserialize(request.requestBody.toString(), Case.class);
        thisCase.Id = caseId;
        upsert thisCase;
        return thisCase.Id;
    }

    @HttpPatch
    global static ID updateCaseFields(){
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Case thisCase = [SELECT Id
                         FROM Case
                         WHERE Id = :caseId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
        for (String fieldName : params.keySet()){
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }

}