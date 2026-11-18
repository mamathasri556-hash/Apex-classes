public class stringtoIntegerConvert {
/**
 * converting the String to integer
 */
    
    public static String dataTypeConvert(String age) {
        Integer sInteger = Integer.valueOf(age);
        String result = sInteger>=18? 'Eligible':'notEligible';
        return result;
    } 
    
}