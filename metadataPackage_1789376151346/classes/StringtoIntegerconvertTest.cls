/**
 *@description converting the String to integer
 */
@isTest
public class StringtoIntegerconvertTest{
    @isTest 
    /**
     * @description -converting the String to integer
     * @Apex class StringtointegerConvert
     */
     static void testdatatypeconverttMethod(){
        String age = '26';
        String result = Stringtointegerconvert.datatypeconvert(age);
        System.assertEquals('Eligible',result,'result should be Eligible'); 
        
        age = '4';
        result = Stringtointegerconvert.datatypeconvert(age);
        System.assertEquals('notEligible',result,'result should be not Eligible'); 
        
    }
}