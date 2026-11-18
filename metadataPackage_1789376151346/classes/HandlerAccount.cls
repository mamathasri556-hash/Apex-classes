public class HandlerAccount { 
    public static void AfterInsert(List<Account> accounts){
        Set<Id> accountIds = new Set<Id>(); 
        for(Account acc: accounts){
            accountIds.add(acc.Id);
        } 
        HandlerFutureMethod.loAccountCreation(accountIds);
    }

}