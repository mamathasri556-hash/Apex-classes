@isTest
public class DivisibleByFiveTest {
    @isTest 
    public static void testPrintNumber(){
        Test.startTest();
        List<Integer> result = DivisibleByFive.printNumbers();
        Test.stopTest();
        
        System.assertEquals(20,result.size(),'List size must be 20');
        
    }
    
}