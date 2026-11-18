/**
 * @description- cstroin the nested list data of person in using map
 */
@isTest
public class NesstedCollectionTest {
    /**
     * @description- cstroin the nested list data of person in using map
     * @Apex class - NesstedCollections
     * return result 
     */
    @isTest
    public static void collectionOfNested(){
       List<String> result=nestedCollections.collectionOfDetails();
        System.assertEquals('pamarthiMamathasri',result[0]);
        System.assertEquals('Btech',result[1]);  
    /**
     * @description- cstroin the nested list data of person in using map
     * @Apex class - NesstedCollections
     * return result 
     */
        
        result=nestedCollections.collectionOfDetails();
        System.assertEquals('sheruAnitha',result[0]);
        System.assertEquals('btech',result[1]);
        
    }

}