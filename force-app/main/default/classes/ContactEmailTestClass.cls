@istest
public class ContactEmailTestClass { 
    @istest 
    public static void getEmailDataTest(){
        Contact con = new Contact(
            LastName = 'sri',
            Email = 'Mamathapamarthi04@gmail.com' 
        ); 
        insert con; 
        System.assertEquals('Mamathapamarthi04@gmail.com',con.Email,'both are same');
    } 
    @isTest 
    public static void EmailTest(){
        Contact con1 = new Contact( 
        LastName = 'mammu',
        Email = '' 
        ); 
        insert con1; 
        System.assertEquals('',con1.Email,'no Email for this so continue and enter the Email');
    }
    
    
}