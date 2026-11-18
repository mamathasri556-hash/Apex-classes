/**
 * @description Calculating the Total Bonus
 * 				First we calculate Bonus based on salary(10%)
 * 				Then we use the bonus to calcualte the total salary
 */
public class CalculateSalaryBonus {
    /**
     * @description Calculates the bonus for given salary
     * @param salary salary to calculate the bonus
     * @return Double returns the calcuated bonus
     */
    public static Double calculateBonus(Integer salary){
        Double bonus = salary * 0.1;
        return bonus;
    }
    
    public static Double calculateTotalSalary(Integer salary){
        Double totalSalary = salary + calculateBonus(salary);
        return totalSalary;
    }
    
}