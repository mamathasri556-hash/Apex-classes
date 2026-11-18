@isTest
public class SetOperationTest {
    @isTest
    public static void operationSet(){
        Set<String> result = SetOperations.emailOfCustom();
        System.assertEquals(1,result.size(),'after comapring two emailPrint only repeadtedEmail');
    }
}