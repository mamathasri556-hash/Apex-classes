/**
 * @description - getting the grouby of one id
 */
public class groupByMaps {
    /**
     * @description - getiting the group OFOne Id
     * @Apex class - Maps test 
     * #return - getId(101)
     */
    public static List<Long> detailsOFPerson(){
        Map<Integer,List<Long>>Id = new Map<Integer,List<Long>>();
        Id.put(101,new List<Long>{9603317815L, 9848489255L});
            Id.put(102,new List<Long>{6666666666L, 7777777777L}); 
        return Id.get(101);
    }
    
}