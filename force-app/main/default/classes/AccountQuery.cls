public class AccountQuery {
    public static List<Account> queryOfAccounts(){
        List<Account> accounts = [
            SELECT Name, AnnualRevenue
            FROM Account 
            WHERE Industry = 'Technology'
        ]; 
        for(Account acc: accounts){
            System.debug('Name ' + acc.Name);
            System.debug('Annual Revenue: '+ acc.AnnualRevenue);
            
        } 
        return accounts;
    }
    
}