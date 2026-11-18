@isTest
public class ContactTriggerBFInsertHandlerTest { 
    @isTest 
    public static void InsertTestmethod(){
        Contact con = new Contact(
        LastName = ' sri',
        Email = 'mamatha@gamil.com'
             ); 
        insert con;   
        Contact result = [ 
        SELECT Id, Email,LastName
        FROM Contact 
        WHERE Id = :con.Id
        ];
       /* try{
            insert con;
        } catch(DmlException e){ 
            System.assertEquals(true, e.getMessage().contains('Email is Required'));*/
        System.assertEquals('mamatha@gamil.com',result.Email);
            
        }
       
    }