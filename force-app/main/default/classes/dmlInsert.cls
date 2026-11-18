public class dmlInsert {
    public static List<Account> accountsDmlInsert(){
        List<Account> result = new List<Account>();
        Account Ac1 = new Account(
        Name = 'Amce' 
        ); 
        insert Ac1;
        Contact con1 = new Contact(
        FirstName = 'mamatha',
        LastName  = 'sri',  
        AccountId = Ac1.Id
        );  
        insert con1; 
        result.add(Ac1); 
        System.debug(con1);
        return result;
        
    }

}