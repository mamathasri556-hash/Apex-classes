public class ChildToparent { 
    public static List<Contact> parentChild(){
        List<Contact> contacts = 
            [ 
                SELECT FirstName,
                       Lastname,
                       Account.Name,
                       Account.Industry 
                FROM Contact
            ]; 
        for (Contact con : contacts){
            System.debug('Conctact Name: '+con.FirstName + ' ' + con.LastName);
            if(con.Account !=null){
                System.debug('Account name' + con.Account.Name);
                System.debug('Account Industry' + con.Account.Industry);
            } 
        } 
        return contacts;
    }
    
}