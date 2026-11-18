@isTest
public class DormatAccountTest {
    @isTest 
    public static void testBatchUpdate(){
        Account acc = new Account(
        Name = 'Test Account'
        );
        insert acc;
        Test.startTest();
        Database.executeBatch(
        new DormatAccount(),10
        );
        Test.stopTest();
        Account result = [ 
        SELECT Id, Description
        FROM Account 
        WHERE Id = :acc.Id];
        System.assertEquals(
        'Description was updated',result.Description);
        
    }

}