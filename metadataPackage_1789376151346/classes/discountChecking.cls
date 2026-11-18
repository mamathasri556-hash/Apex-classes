/**
 * @description checking the the person get discount or not
 */
public class discountChecking {
    public static string checkingQualified(){
        integer Age = 44;
        integer Amount = 8000;
        String result = (Age>60 || Amount>5000)? 'qualifiedForDiscount':'disqulaifiedForDiscount';
        Return result;
        
        
    }
    
}