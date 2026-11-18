public class ParenetToChild {
    public static list<Account>childToParent(){
        List<Account> accounts = [
            SELECT Name,
            (SELECT FirstName, LastName FROM Contacts)
            FROM Account
        ]; 
        For(Account acc: accounts){
            System.debug('Account Name: '+acc.Name);
            for(Contact con : acc.Contacts){
                System.debug('Frist Name:' + con.FirstName);
                System.debug('Last name:'+ con.LastName );
            }
        }
        return accounts;
    }
    
}