public class FutureMethod {
	@future(callout=true)
    public static void myFutureCalloutMethod(Decimal eur){
        Decimal inr = 0.0;
        
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('https://api.fxratesapi.com/latest');
        req.setMethod('GET');
        
        HTTPResponse res = h.send(req);
        
        Map<String, Object> jsonBody = (Map<String, Object>)Json.deserializeUntyped(res.getBody());
        
        System.debug(jsonBody);
        
        Map<String, Object> mMap = (Map<String, Object>) jsonBody.get('rates');
        
        Decimal conversionRate = (Decimal) mMap.get('INR');
        
        inr = eur * conversionRate;
        System.debug(inr);
    }
}