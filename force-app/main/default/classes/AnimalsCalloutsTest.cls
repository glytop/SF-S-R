@isTest
private class AnimalsCalloutsTest {
    @isTest 
    static void testGetCallout() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);

        HttpResponse result = AnimalsCallouts.makeGetCallout();

        Assert.areNotEqual(null,result, 'The callout returned a null response.');
        Assert.areEqual(200,result.getStatusCode(), 'The status code is not 200.');
        Assert.areEqual('application/json;charset=UTF-8',
          result.getHeader('Content-Type'),
          'The content type value is not expected.');

        Map<String, Object> results = (Map<String, Object>)
            JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');

        Assert.areEqual(3, animals.size(), 'The array should only contain 3 items.');
    }
    
    @isTest
    static void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        HttpResponse response = AnimalsCallouts.makePostCallout();
        String contentType = response.getHeader('Content-Type');
        
        Assert.isTrue(contentType == 'application/json');

        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';

        Assert.areEqual(expectedValue, actualValue);
        Assert.areEqual(200, response.getStatusCode());
	}
}