@isTest
public class AccountqueryTest {
    @isTest
    public static void queryAccount(){
        Account Acc = new Account(
            Name = 'Tech Account',
            Industry = 'technology',
            AnnualRevenue = 100000
        ); 
        insert acc;
        list<Account> result = AccountQuery.queryOfAccounts();
        System.assertNotEquals(0,result.size());
    }
    
}