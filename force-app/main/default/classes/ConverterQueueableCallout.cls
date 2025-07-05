public with sharing class ConverterQueueableCallout implements Queueable, Database.AllowsCallouts{
    private String baseCurrency;
    private String targetCurrency;
    private Decimal amount;

    public ConverterQueueableCallout(String baseCurrency, String targetCurrency, Decimal amount){
        this.baseCurrency = baseCurrency;
        this.targetCurrency = targetCurrency;
        this.amount = amount;
    }

    public void execute(QueueableContext context){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.fxratesapi.com/latest');
        req.setMethod('GET');

        HttpResponse res = new Http().send(req);

        FxResponse data = (FxResponse)Json.deserialize(res.getBody(), FxResponse.class);
        Decimal rate = data.rates.get(targetCurrency);
        Decimal converted = amount * rate;

        if (!Test.isRunningTest()) {
            System.enqueueJob(new CurrencyLoggingJob(baseCurrency, targetCurrency, amount, rate));
        }
    }

}