/**
 * @description Account name and Techology
 */
public class ListObject{ 
    /**
     * @description Account name and techology 
     * Apex class - ListObjec
     */
    public static  void objectDetails(){
        List<Account>accounts=new List<Account>();
            accounts.add(new Account(Name='infosys',Industry='techology'));
            accounts.add(new Account(Name='wipro',Industry='software'));
            accounts.add(new Account(name='Delottie',Industry='techology'));
            accounts.add(new Account(name='Sutherland',Industry='BPo company'));
            accounts.add(new Account(name='tcs',Industry='hardware'));
            for(Integer i=0;i<accounts.size(); i++) {
                System.debug(accounts[i].Name + ' - '+ accounts[i].industry);
            } 
        
       } 
}