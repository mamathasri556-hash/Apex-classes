@isTest
public class AccountUpdateTest { 
    @isTest 
    public static void testAccountmethod(){
        Account acc = new Account(Name='test');
        insert acc; 
        List<Account> result = AccountUpdate.updateAnnulaRevenue();
    }

}