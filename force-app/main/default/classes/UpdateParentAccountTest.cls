/**
 * @description       : 
 * @author            : Maksimilian Ramanets
 * @group             : 
 * @last modified on  : 06-13-2025
 * @last modified by  : Maksimilian Ramanets
**/
@isTest
public class UpdateParentAccountTest {
    @TestSetup
    static void makeData(){
        List<Account> accList = new List<Account>();

        accList.add(new Account(Name='Parent'));

        for (Integer i = 0; i< 100; i++) {
            accList.add(new Account(Name='Test Account' + i ));
        }

        insert accList;
    }

    @isTest
    private static void Queueable(){
        Id parentId = [SELECT Id FROM Account WHERE Name='Parent'][0].Id;

        List<Account> accList = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%'];

        UpdateParentAccount updateJob = new UpdateParentAccount(accList, parentId);

        Test.startTest();
        System.enqueueJob(updateJob);
        Test.stopTest();

        System.assertEquals(100, [SELECT COUNT() FROM Account WHERE ParentId = :parentId]);
    } 
}