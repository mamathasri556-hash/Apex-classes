public class AccountPhoneNumber {
    public static void phoneNumber(List<Account>  accs, map<Id, Account>oldMap){
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : accs){
            Account oldAcc = oldMap.get(acc.Id);
            if(oldAcc.Phone != acc.Phone){
                accountIds.add(acc.Id);
            }
        } 
       List<Contact> conList = [SELECT Id, AccountId 
           FROM Contact
           WHERE AccountId IN: accountIds];
    }

}