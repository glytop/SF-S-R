public with sharing class ExchangeRateController{
    
    @AuraEnabled
    public static Decimal convert(Decimal usd, String target){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.fxratesapi.com/latest');
        req.setMethod('GET');
        HttpResponse res = new Http().send(req);

        if (res.getStatusCode() != 200){
            throw new AuraHandledException('Error getting course');
        }

        FxResponse fx = (FxResponse)Json.deserialize(res.getBody(), FxResponse.class);

        Decimal rate = fx.rates.get(target);
        if (rate == null){
            throw new AuraHandledException('Rate not found');
        }

        return usd * rate;
    }

}