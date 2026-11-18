/**
 * @description-check the email was duplicate and retunr in other set
 */
public class setsRemovingDuplicates{
    /**
     * @description - check the email was duplicate  and return in other set
     * Apex class - SetsRemovingDuplicates
     * return - unique email
     */
    public static Set<String> removingDuplicates(){
        List<String> emails = new List<string>{
            'mamathapamarthi04@gmail.com',
            'mamathasri0@gmail.com',
            'mamathapamarthi04@gmail.com',
            'mamathasri0@gmail.com',
            'salesforce@gmail.com'

         };
        Set<String> uniqueEmails = new Set<String>(emails);
        return uniqueEmails;
    }
}