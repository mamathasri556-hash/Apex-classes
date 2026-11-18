@isTest
public class AccountTriggersTest { 
    @isTest 
    public static void accountTestingMethod(){
        Account acc = new Account( 
        Name = 'Test Account'
        ); 
        List<Account> accounts = new List<Account>{acc};
        AccountTriggersHandler.ExeceptingTestmethod(accounts);
        System.assertEquals('Warm',acc.Rating);
    }

        @isTest
        public static void accountdeletingTestingMethod(){
            Account acc = new Account(
            Name = 'Opp1'
            ); 
            insert acc; 
            Opportunity opps = new Opportunity(
            Name = 'Test Opporrtunity',
            AccountID = acc.Id,
            StageName='Closed Won',
            CloseDate = Date.today()
            );
            insert opps;
            Test.startTest();
                try{
                    delete acc;
                    System.assert(false,'deleting the be prevented');
                    
                } 
                Catch(DmlException e){
                    System.assert(
                    e.getMessage().contains('Cannot delete')
                    );
                }
                Test.stopTest();
            } 
    @isTest
    public static void getTestMethods(){
        Account acc = new Account( 
        Name = 'sri',
        Industry = 'Healthcare',
        Rating = 'Hot' 
        ); 
        insert acc; 
        acc = [SELECT Rating FROM Account WHERE Id = :acc.Id];
        } 
}