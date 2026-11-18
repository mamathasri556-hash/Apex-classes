public class StudentMarks{
    public static String marksOfSubject(Integer num){
        if(num>=90 && num<=100){
            return 'A';
        }else if(num>=75 && num<=89){
            return 'B';
        }else if(num>=50 && num<=74){
            return 'C';
        } else if(num>=0 && num<=55){
            return 'fail';
        } else{
            return 'Invaid Marks';
        }
        
    }
    
}