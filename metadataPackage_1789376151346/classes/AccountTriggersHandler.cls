public class AccountTriggersHandler { 
    public static void ExeceptingTestmethod(List<Account> newAccounts
            ){
                for(Account acc : newAccounts){
                    if(acc.Rating == null){
                        acc.Rating = 'Warm';
                    }
                }
            }
   
    public static void deleting(List<Account> oldAccounts){
        Set<id> accIds = new Set<Id>();
        for(Account acc : oldAccounts){
            accIds.add(acc.Id);
            
        } 
        List<opportunity> opps = [ 
        SELECT Id, AccountId, Stagename
        FROM Opportunity 
        WHERE Accountid IN :accIds
        AND Stagename = 'Closed Won'
        ]; 
        Set<id> AccountClosed = new Set<Id>();
        for(Opportunity opp : opps){
            accountClosed.add(opp.AccountId);
        } 
        for(Account acc : oldAccounts){
            if(accountClosed.contains(acc.Id)){
                acc.addError('Cannot delete');
            }
        }
    }
        
    }