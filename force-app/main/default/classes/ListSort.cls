/** 
 * @description sort the list and priting frsit 3 values
 */
public class ListSort{
    /**
     * @description Assign the list sort the list using the reversce order and then print grethen 3 values
     * @Apex class - ListSort
     * @return list 
     */
    public static List<Integer> getAmount(){
        List<Integer> amount = new List<Integer>{
            50,
            79,
            33,
            66,
            23
        };  
        List<Integer> top3 = new List<Integer>();
        amount.sort(); 
        Integer count  = 0;
        for (Integer i = amount.size()-1; i >=0; i--){
            system.debug(amount[i]); 
            }   
        top3.add(amount[4]);
        top3.add(amount[3]);
        top3.add(amount[2]);
        return top3;
    }
}