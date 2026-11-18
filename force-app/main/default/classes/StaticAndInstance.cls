public class StaticAndInstance { 
    public Static Integer count = 0;
     String Name;
     Decimal salary; 
     StaticAndInstance(String Name,Decimal salary){
        this.Name = Name;
        this.salary = salary;
        count = count+1;
    } 
    public Integer  Method(String Name,Decimal salary){
        this.Name = Name;
        this.salary = salary; 
        return count;
    } 
    public static Integer testMethodObject(){
        StaticAndInstance obj1 = new StaticAndInstance('Mamatha',5000);
        StaticAndInstance obj2 = new StaticAndInstance('sri',500);  
        StaticAndInstance obj3 = new StaticAndInstance('mammu',500);
        return count;
    }
 }