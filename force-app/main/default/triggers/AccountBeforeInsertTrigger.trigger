trigger AccountBeforeInsertTrigger on Account(before insert, before update){
    List<Account> accountWithContacts = [SELECT Id, Name, (SELECT Id, FirstName, LastName, Email, Description
                                                           FROM Contacts)
                                         FROM Account
                                         WHERE Id IN:Trigger.newMap.keySet()];
    List<Contact> contactsToUpdate = new List<Contact>();

    for (Account a : accountWithContacts){
        for (Contact c : a.Contacts){
            c.Description = c.FirstName + ' ' + c.LastName + ' ' + c.Email;
            contactsToUpdate.add(c);
        }
    }

    update contactsToUpdate;
}