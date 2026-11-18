/**
 * 
 * @description Adding the two strings
 */
 
@isTest
public class StringConatenationTest{ 
    /**
     * @description Adding the fristname and lastname
     * @param fristname,lastname both name are used to add as one name
     * @return String returns the name
     */
 
   @isTest
   public static  void testGetNameMethod(){
        String name = StringConcatenation.getName();
        System.assertEquals('Welcome JohnDeo', name, 'return must be equal to the name');
        
    }
}