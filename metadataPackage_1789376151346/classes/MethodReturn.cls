public class MethodReturn { 
    Integer salary; 
    Integer  Experience;  
    Integer category; 
    Decimal bonus;
    public Decimal method (Integer Experience, Integer salary,Decimal bonus){
        if(Experience>=0 && Experience<=5){
            bonus = salary * 0.05;  
        } else if(Experience>=5 && Experience<=10){
            bonus = salary *0.10;
                } else {
                    System.debug('Ntg');
                        } 
        return bonus;
        
    } 
    public static Decimal testmethodsalary(){
        MethodReturn obj = new MethodReturn(); 
        obj.bonus=obj.method(6,300,0);  
        obj.bonus=obj.method(1,20,1); 
        Decimal result =obj.bonus;
        return result;
            
            }
    
}