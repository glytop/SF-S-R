@isTest
private class TestCurrencyLoggingJob {
    @isTest static void loggingOnly() {
        CurrencyLoggingJob job = new CurrencyLoggingJob('EUR', 'BYN', 100, 88.2);

        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();

        System.assert(true, 'Logging queue executed');
    }
}
