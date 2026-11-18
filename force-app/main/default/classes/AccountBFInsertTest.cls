@isTest
public class AccountBFInsertTest {  
    @isTest 
    public static void ratingTestMethod(){
        Account  acc = new Account(
        Name = 'sri'); 
        insert acc; 
        Account Result = [ 
        SELECT Id, Rating
        FROM Account
        ]; 
        System.assertEquals('Warm',Result.Rating,'AccountRating is Warm');
        
    } 

}