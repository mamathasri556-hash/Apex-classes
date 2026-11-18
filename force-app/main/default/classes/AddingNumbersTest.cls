/**
 * @description:Adding the given number
 */
@isTest
public class AddingNumbersTest {
    /**
     * @description Adding the given number using the while loop
     * @Apex class AddingNumbers
     * return result after Adding the number
     */
    @isTest
    public static void testNumberAdditionMethod(){
        Integer num = 123;
        Integer result=AddingNumbers.numberAddition(num);
        System.assertEquals(6,result,'After Adding the numbe it will be six');  
                
     /**
     * @description Adding the given number using the while loop
     * @Apex class AddingNumbers
     * return result after Adding the number
     */
        num = 124;
        result=AddingNumbers.numberAddition(num);
        System.assertEquals(7,result,'After Adding the numbe it will be seven');
        
    }
    
}