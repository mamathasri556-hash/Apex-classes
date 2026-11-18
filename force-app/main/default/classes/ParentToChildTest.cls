@isTest
public class ParentToChildTest {
    @isTest
    Public static void testtoChildMethod(){
        Account acc = new Account(
            Name = 'test Account');
        insert acc; 
        Contact con = new Contact(
            FirstName = 'mamatha',
            lastName = 'Sri',
            AccountId = acc.Id
        ); 
        insert con;
        list<Account> result = ParenetToChild.childToParent();
        System.assertNotEquals(0,result.size());
    }
    
}