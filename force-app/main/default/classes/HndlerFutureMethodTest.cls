@isTest
public class HndlerFutureMethodTest {
    @isTest 
    public static void testAccountTriggerCallouts(){
        Test.setMock(
        HttpCalloutMock.class,
            new AccountTriggerMockCallout() );
        Account acc = new Account(
        Name = 'Test Account'
        ); 
        Test.startTest(); 
        insert acc; 
        Test.stopTest(); 
        Account result = [ 
        SELECT Id,Name
        FROM Account 
        WHERE Id = :acc.Id
        ];
        System.assertEquals(
        'Test Account',
        result.Name);
       
    }

}