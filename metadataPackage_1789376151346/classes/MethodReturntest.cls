@isTest
public class MethodReturntest { 
    @isTest
    public static void testReturnMethod(){
        decimal result =MethodReturn.testmethodsalary();
        System.assertEquals(30,result);  
        
        result = MethodReturn.testmethodsalary();
        System.assertEquals(1,result);
        
    }

}