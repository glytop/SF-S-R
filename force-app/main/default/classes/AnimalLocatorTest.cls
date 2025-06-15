/**
 * @description       : 
 * @author            : Maksimilian Ramanets
 * @group             : 
 * @last modified on  : 06-14-2025
 * @last modified by  : Maksimilian Ramanets
**/
@isTest
private class AnimalLocatorTest {
	@isTest
    static void testGet() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result = AnimalLocator.getAnimalNameById(7);
        System.assertNotEquals(null, result,
                               'The callout returned a null response.');        
        System.assertEquals('dog', result,
                            'The animal name should be \'dog\'');          
    } 
}