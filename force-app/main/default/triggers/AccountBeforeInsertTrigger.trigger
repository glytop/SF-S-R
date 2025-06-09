trigger AccountBeforeInsertTrigger on Account (after insert, after update) {
    List<Account> accountWithContacts = [
        SELECT Id, Name, (SELECT Id, LastName, Description FROM Contacts)
        FROM Account
        WHERE Id IN :Trigger.newMap.keySet()
    ];

    List<Contact> contactsToUpdate = new List<Contact>();

    for (Account a : accountWithContacts) {
        for (Contact c : a.Contacts) {
            c.Description = c.LastName;
            contactsToUpdate.add(c);
        }
    }

    if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }
}