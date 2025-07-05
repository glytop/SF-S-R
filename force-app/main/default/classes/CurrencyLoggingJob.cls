public with sharing class CurrencyLoggingJob implements Queueable {
    private String fromm;
    private String to;
    private Decimal input;
    private Decimal rate;

    public CurrencyLoggingJob(String fromm, String to, Decimal input, Decimal rate){
        this.fromm = fromm;
        this.to = to;
        this.input = input;
        this.rate = rate;
    }

    public void execute(QueueableContext context) {
        Decimal converted = input * rate;
        System.debug(input + ' ' + fromm + ' ' + converted + ' ' + to);
    }
}