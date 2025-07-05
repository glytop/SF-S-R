public class FutureMethod{
    @future(callout = true)
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

        /*
         List<Contact> contacts = [SELECT Id, Name, Email FROM Contact LIMIT 10];
         String contactsJson = JSON.serialize(contacts);

         processContactsAsync(contactsJson);

         @future
         public static void processContactsAsync(String contactsJson) {
         List<Contact> contacts = (List<Contact>)JSON.deserialize(contactsJson, List<Contact>.class);

         for(Contact c : contacts) {
         c.Description = 'Processed at ' + System.now();
         }
         update contacts;
         }

         */
    }
}