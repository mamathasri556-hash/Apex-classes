/**
 * @description separting the domainFromTheEmail
 */
@isTest
public class domainSeparationTest {  
    /**
     * @description separting The Domainform the email
     * @apexclass domainSeparation
     * @return the string 
     */
    @isTest
    public static void testEmailDomainMethod(){
        String Email = 'mamathapamarthi04@salesforce.com';
        String result = domainSeparation.emailDomain();
        System.assertEquals('salesforce.com',result,'result Must be domainSeperated');
        
    }
    
}