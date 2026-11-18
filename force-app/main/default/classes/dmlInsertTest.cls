@isTest
public class dmlInsertTest { 
    @isTest
    public static void testDmlMethod(){
        List<Account> result = new List<Account>();
        Account ac1 = new Account(
            Name = 'sri'
        ); 
        Contact con = new Contact(
            FirstName = 'mamatha',
            LastName = 'sri'
        ); 
        insert ac1;
        insert con; 
        List<Account> acc = dmlInsert.accountsDmlInsert();
        System.assertNotEquals(0,result.size());
        
    }
    
}