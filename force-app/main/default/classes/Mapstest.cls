/**
 * @description display the product price based on there value 
 * Apex class - maps 
 * return result prodcut price
 */
@isTest
public class Mapstest { 
    @isTest
    public static void retunringTheProdcutPrice(){
        Integer num = 2;
        Integer result = Maps.keyValuepairs();
        System.assertEquals(600,result,'both are must be same'); 
        
        num = 3;
        result = Maps.keyValuepairs();
        System.assertEquals(600,result,'both are must be same'); 
        
        
        num = 1;
        result = Maps.keyValuepairs();
        System.assertEquals(600,result,'both are must be same'); 
        
        
    }
    
}