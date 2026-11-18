/**
 * @description Assign the list sort the list using the reversce order and then print grethen 3 values
 */
@isTest
public class testSortList { 
    /**
     * @description -Assign the list sort the list using the reversce order and then print grethen 3 values
     * @Apex class testSortList
     * return result of 3 number
     */
     @isTest
        public static void sortingMethod(){
            List<integer> result = ListSort.getAmount();
            System.assertEquals(79,result[0]);
            System.assertEquals(66,result[1]); 
            System.assertEquals(50,result[2]); 
        }

}