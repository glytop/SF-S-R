public class FutureMethod {
	@future(callout=true)
    public static void myFutureCalloutMethod(Decimal eur){
        Decimal inr = 0.0;
        
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('https://api.fxratesapi.com/latest');
        req.setMethod('GET');
        
        HTTPResponse res = h.send(req);
        
        //Map<String, Object> jsonBody = (Map<String, Object>)Json.deserializeUntyped(res.getBody());
        FxResponse jsonBody = (FxResponse)Json.deserialize(res.getBody(), FxResponse.class); 
        
        System.debug(jsonBody);
                
        Decimal conversionRate = jsonBody.rates.get('INR');
        
        inr = eur * conversionRate;
        System.debug(inr);
    }
}