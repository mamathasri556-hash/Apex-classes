@isTest
public class StudentMarksTest {
    @isTest
    public Static void testMarks(){
        Integer num = 77;
        String result = Studentmarks.marksOfSubject(num);
        System.assertEquals('B',result,'Result should be B'); 
        
        num = 99;
        result = StudentMarks.marksOfSubject(num);
        System.assertEquals('A',result,'Result should be A'); 
        
        num = 66;
        result = StudentMarks.marksOfSubject(num);
        System.assertEquals('C',result,'Result should be C'); 
        
        num = 44;
        result = StudentMarks.marksOfSubject(num);
        System.assertEquals('fail',result,'Result should be fail'); 
        
        num = -10;
        result = StudentMarks.marksOfSubject(num);
        System.assertEquals('Invalid',result,'-10Invalid'); 
        
        
        
    }
    
}