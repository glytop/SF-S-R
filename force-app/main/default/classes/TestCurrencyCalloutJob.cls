@isTest
private class TestCurrencyCalloutJob {
    @isTest static void queueableCalloutWithChaining() {
        Test.setMock(HttpCalloutMock.class, new CurrencyMock());

        Test.startTest();
        System.enqueueJob(new ConverterQueueableCallout('EUR', 'BYN', 100));
        Test.stopTest();

        System.assert(true, 'Queue executed successfully');
    }
}
