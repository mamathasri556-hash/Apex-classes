/**
     * @description checking even or odd
     */
public class EvenOrOdd{
    public static String evenOrOddMethod(){ 
        Integer num = 3;
        if(Math.mod(num,2) == 0){
            return 'even';
        }else{
            return 'odd';
        }
        
    }
}