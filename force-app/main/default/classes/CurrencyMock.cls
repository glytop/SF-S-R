@isTest
global class CurrencyMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('{"rates":{"BYN":88.2,"USD":1.08}}');
        return res;
    }
}
