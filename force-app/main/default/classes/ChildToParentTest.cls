@isTest
public class ChildToParentTest {

    @isTest
    static void testParentChild() {

        Account acc = new Account(Name='Test Account', Industry='Technology');
        insert acc;

        insert new Contact(
            FirstName='Mamatha',
            LastName='Sri',
            AccountId=acc.Id
        );

        List<Contact> result = ChildToparent.parentChild();

        System.assertEquals(1, result.size());
        System.assertEquals('Test Account', result[0].Account.Name);
    }
}