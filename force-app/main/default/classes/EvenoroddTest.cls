/**
 * @description:checking the given number was even or odd
 */
@isTest
public class EvenoroddTest{ 
    /**
     * @description checking the given number was even or odd
     * @Apex class Evenorodd
     * return result number even or odd
     */
    @isTest
    public static void testEvenOrOddMethod(){ 
        Integer num = 3; 
        string result = Evenorodd.evenOrOddMethod(num);
        System.assertEquals('odd',result,'result should be odd');
        
        num = 6;
        result = Evenorodd.evenOrOddMethod(num);
        System.assertEquals('even', result, 'Result should be equals to even');   
        
        
    }
}