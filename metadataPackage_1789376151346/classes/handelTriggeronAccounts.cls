public class handelTriggeronAccounts { 
    public static void AccountsTestMethod(List<Account> accounts){
        Set<Id> accountIds = new Set<Id>(); 
        for(Account acc : accounts){
            accountIds.add(acc.Id);  
            System.debug('Handler Started');
        }  
        AccountCallout.logAccountCreation(accountIds);
        
    } 
}