/**
 * description based id getting id based details
 */
@isTest
public class groupByMapsTest {
    /**
     *@description based id getting id based details
     *@Apexclass groupBymaps
     *@return result
     */
    @isTest
    public static void testAccountIdMethod(){
        List<Long> result = groupByMaps.detailsOFPerson();
        System.assertEquals(9603317815L,result[0]);
        System.assertEquals(9848489255L,result[1]); 
    /**
     *@description based id getting id based details
     *@Apexclass groupBymaps
     *@return result
     */
        
        result = groupByMaps.detailsOFPerson();
        System.assertEquals(6666666666L,result[0]);
        System.assertEquals(7777777777L,result[1]);
    }

}