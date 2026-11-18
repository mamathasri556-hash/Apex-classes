@isTest
public class HandlerEmailOdContactTest {
    @isTest
    public static void getTestMethod(){
        Contact con = new Contact (
        LastName = 'sri',
        Email = 'mamatha@gmail.com'
        ); 
        insert con;
       con.Email = 'sripamarthi04@gamil.com';
       update con; 
       System.assertEquals('sripamarthi04@gamil.com',con.Email,'Email was updated');
    }

}