@isTest
public class DeleteContactsExampleTest {

    @isTest
    static void testDeleteContacts() {

       
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'Contact1', AccountId = acc.Id),
            new Contact(LastName = 'Contact2', AccountId = acc.Id)
        };
        insert contacts;

        Test.startTest();
        DeleteContactsExample.deleteContacts(acc.Id);
        Test.stopTest();

        List<Contact> remainingContacts = [
            SELECT Id
            FROM Contact
            WHERE AccountId = :acc.Id
        ];

        System.assertEquals(
            2,
            remainingContacts.size(),
            'Contacts should exist because rollback restored them'
        );
    }
}