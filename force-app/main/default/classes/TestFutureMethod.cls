@isTest
public class TestFutureMethod {
	@isTest
    public static void testMyFutureCalloutMethod(){
        Test.startTest();
        FutureMethod.myFutureCalloutMethod(100);
        Test.stopTest();
    }
}