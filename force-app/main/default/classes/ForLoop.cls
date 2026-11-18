/**
 * @description priting the for loop 1 to 100 check only print number divible by 5
 */
public class ForLoop {
    public static List<Integer> divibleByFive(){
        List<Integer>count=new List<Integer>();
        for (Integer i = 1; i<=100; i++){
            if(Math.mod(i,5)==0){
                System.debug(i);
                count.add(i);
                
            }
        } 
        return count;
    }

}