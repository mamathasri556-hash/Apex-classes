/**
 * @description check the person to get the dicount or not
 */
@isTest 
/**
 * @description check the person to get the dicount or not 
 * @Apex class discountChecking
 * return the QualifiedForDiscount
 */

public class discountCheckingTest {
    @istest
    public static void testDiscountMethod(){
        Integer age = 44;
        Integer amount = 800;
        String result=discountChecking.checkingQualified();
        System.assertEquals('qualifiedForDiscount',result,'age amount any thing is qulaified');
/**
 * @description check the person to get the dicount or not 
 * @Apex class discountChecking
 * return the QualifiedForDiscount
 */

        
        age = 77;
        amount = 400;
        result = discountChecking.checkingQualified();
        System.assertEquals('disqulaifiedForDiscount',result,'age amount any thing is notqulaified');
    }
 }