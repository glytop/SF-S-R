global class CaseSoapService {
    global class CaseWrapper {
        webService String id;
        webService String subject;
        webService String status;
    }
    
    webService static String createCase(String subject, String status) {
        Case c = new Case(Subject = subject, Status = status);
        insert c;
        return c.Id;
    }
    
    webService static CaseWrapper getCaseById(String caseId) {
        Case c = [SELECT Id, Subject, Status FROM Case WHERE Id = :caseId LIMIT 1];
        
        CaseWrapper wrapper = new CaseWrapper();
        wrapper.id = c.Id;
        wrapper.subject = c.Subject;
        wrapper.status = c.Status;
        return wrapper;
    }
}