public class DeleteContactsExample {

    public static void deleteContacts(Id accountId) {

        Savepoint sp = Database.setSavepoint();

        try {
            List<Contact> contactsToDelete = [
                SELECT Id, FirstName, LastName
                FROM Contact
                WHERE AccountId = :accountId
            ];
            delete contactsToDelete;

            System.debug('Contacts deleted successfully');

            Integer x = 10 / 0;

        } catch (Exception e) {

            Database.rollback(sp);

            System.debug('Rollback executed: ' + e.getMessage());
        }
    }
}