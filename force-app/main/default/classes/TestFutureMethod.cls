@isTest
public class TestFutureMethod {
	@isTest
    public static void testMyFutureCalloutMethod(){
        Test.setMock(HttpCalloutMock.class, new FxMock());
        
        Test.startTest();
        FutureMethod.myFutureCalloutMethod(100);
        Test.stopTest();
    }
}