/**
 * @description Test Class for Calcuate Salary Bonus Apex Class
 */
@isTest
public class CalculateSalaryBonusTest {
    /**
     * @description calculate the bonus of the given salary and after calculate the total salary 
     * @Apex class CalculateSalaryBonus
     * return result total calculatesalarybonusand calculatedtotoal salary 
     */
    @isTest
    static void testCalculateTotalSalaryMethod(){
        Integer salary = 100000;
        Double result = CalculateSalaryBonus.calculateTotalSalary(salary);
        
        System.assertEquals(110000, result, 'result should be equal to totalSalary');
        
    }
}