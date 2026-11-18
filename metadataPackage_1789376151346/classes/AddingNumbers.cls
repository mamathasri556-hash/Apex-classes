/**
 * @description:Adding the given number
 */
public class AddingNumbers{
    public static Integer numberAddition(Integer num){
        Integer result = 0;
        while (num>0){
            Integer digit = Math.mod(num,10);
            result = result+digit;
            num = num/10;
        } 
        return result;
    }
}