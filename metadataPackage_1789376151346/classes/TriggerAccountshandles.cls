public class TriggerAccountshandles {
    public static List<Account> updatedAccounts = 
        [ 
        SELECT Id, Name, Customer_Status_c__c
        FROM Account
        ]; 
    

}