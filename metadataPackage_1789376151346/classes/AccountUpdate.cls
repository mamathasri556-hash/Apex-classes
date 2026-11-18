public class AccountUpdate {
    public static List<Account> updateAnnulaRevenue(){
        List<Account> account = [
            SELECT Id, Name, AnnualRevenue
            FROM Account
            WHERE AnnualRevenue = NULL
        ]; 
        for(Account acc: account){
            acc.AnnualRevenue = 100000;
            Update Account;
        }  
        return account;
        
    } /*
    public static List<Lead> updateStatus(){
        List<Lead>lead = [
            SELECT Id, Name, status
            FROM Lead
            WHERE Company = 'ABC'
        ]; 
        for(Lead led: lead){
            led.Status = 'Working - Contacted';
        }  
        Update lead;
        delete lead; 
        upsert lead;
        undelete lead;
        return lead;
    }*/

}