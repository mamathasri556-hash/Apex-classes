/**
 * @description-check the email was duplicate or not
 */
@isTest 
public class SetsRemovingDuplicatesTest {  
    /**
     * @description - check the email was duplicate  and return in other set
     * Apex class - SetsRemovingDuplicates
     * return - unique email
     */
    @isTest
    public static void duplicateEmail(){
        String email='mamathapamarthi04@gmail.com';
        Set< String> result = SetsRemovingDuplicates.removingDuplicates();
        System.assertEquals(3,result.size(),'resultmustbe same to email');
            }
    
}