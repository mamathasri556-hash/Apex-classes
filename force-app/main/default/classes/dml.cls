public class dml{
    public static void dmlSection(){
        Account ac1 = new Account( 
            Name = 'Acme' 
        ); 
        insert ac1; 
        Account ac2 = new Account(
            Name = 'mamatha'
        );  
        Account acc3 = new Account(
            Name = 'sri' 
         );
            insert ac2;
            insert acc3; 
            System.debug(ac1.Id);
            System.debug(ac2.Id);
            System.debug(acc3.Id);
    }
}