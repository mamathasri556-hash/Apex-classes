public class EmployeClass {   
    static  Integer id = 1;
   
    String Name;
    Decimal salary;
    String department; 
    public EmployeClass(){
        
    } 
    public EmployeClass(String Name,Integer id){
        this.Name = Name;
    } 
    public EmployeClass(String Name, Integer id,Decimal salary, String department){
        this.Name = Name; 
        this.salary = salary;
        this.department = department;
    } 
    public Integer sum(Integer num, Integer score){
        System.debug(id);
        return num+score;
    }
    
    public  Decimal calculatorMethod(String Name, Decimal salary,String department) {
        System.debug(id);
        return salary*12;
    }  
    public static decimal testEmpaloye(){
        EmployeClass emp = new EmployeClass(); 
        emp.Name = 'mamatha';
        emp.salary = 600.00;
        emp.department='cse';
        
        Decimal result = emp.calculatorMethod('Mamatha',40,'cse');  
        Integer sumResult = emp.sum(30,30); 
        System.debug(sumResult);
        
        return result;
            } 
}