@isTest
public class AccountTriggerTest {
    @isTest
    static void testAccountAfterInsertTrigger() {
        Account testAccount = new Account(Name = 'Test AccountOOO');
        insert testAccount;

        Contact testContact = new Contact(LastName = 'John Doe', AccountId = testAccount.Id);
        insert testContact;

        testAccount.Name = 'Updated Account';
        update testAccount;

        Contact updatedContact = [SELECT Description FROM Contact WHERE Id = :testContact.Id];
        System.assertEquals('John Doe', updatedContact.Description);
    }
}