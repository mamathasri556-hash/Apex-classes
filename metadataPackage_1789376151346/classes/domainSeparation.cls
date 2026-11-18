/**
* @description separate the domain from email
*/
public class domainSeparation {
    public static String emailDomain(){
        String Email = 'mamathapamarthi04@salesforce.com';
        List<String> domain= Email.split('@');
        
        return domain[1];
        
    } 
    
}