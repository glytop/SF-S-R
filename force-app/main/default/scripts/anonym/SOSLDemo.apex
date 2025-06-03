List<List<SObject>> searchList = [FIND 'Cloud' IN ALL FIELDS RETURNING Account(Name), Contact(FirstName,LastName, Email, Department)];
List<Account> accList = new List<Account>();
List<Contact> conList = new List<Contact>();

accList = (List<Account>) searchList[0];
conList = (List<Contact>) searchList[1];

for (Account acc : accList) {
    System.debug('[Account] - ' + acc.Name);
}

for (Contact con : conList) {
    System.debug('[Contact] - ' + con.FirstName + ' ' + con.LastName + ' ' + con.Email + ' ' + con.Department);
}