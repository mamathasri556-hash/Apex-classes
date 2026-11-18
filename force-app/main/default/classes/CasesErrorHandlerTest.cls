@isTest
public class CasesErrorHandlerTest {
    @isTest
    public static void ErrorMessgae(){
        Case cos = new Case(
            Status = 'New',
            Origin = 'Phone',
            Priority = 'High', 
            Subject = ''); 
        Test.startTest();
        CaseErrorHandler.validateCases(new List<Case>{cos});
        Test.stopTest();
        System.assertEquals(true, cos.hasErrors());
        System.assertEquals(
        'Subject is required', cos.getErrors()[0].getMessage());
    }
        @isTest 
        public static void ErrorTest(){
            Case cos1 = new Case( 
                Status = 'New',
                Origin ='Phone',
                Priority ='High',
                Subject ='yesthere');
            System.assertEquals('yesthere',cos1.Subject); 
            Database.SaveResult sr = Database.insert(cos1, false);
            System.assertEquals(true,sr.isSuccess());
            Test.stopTest();
        } 
    }