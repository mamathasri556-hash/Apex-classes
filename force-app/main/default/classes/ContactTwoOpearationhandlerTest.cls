@isTest
public class ContactTwoOpearationhandlerTest { 
    @isTest 
    public static void getData(){
        Contact con = new Contact( 
        LastName = 'sri',
        Email = 'mamathapamarthi04@gmail.com',
        Department = 'PCI',
        Description = 'yes it was PCI');
        insert con;  
        List<Contact> cons = new List<Contact>{con};
        ContacttwoOperationshandler.getOneOpearation(cons);
        System.assertEquals('yes it was PCI',con.Description,'botharesame');
    } 
    
    public static void get2Data(){
        Contact con = new Contact(
        LastName = 'Sri',
        Email = 'test@gmail'
        ); 
        insert con; 
        ContacttwoOperationshandler.getSecOperation(new List<Contact>{con});
        List <Task> tasks = [ 
        SELECT Id, Subject, Status, WhoId 
        FROM Task 
        WHERE WhoId = :con.Id]; 
        System.assertEquals(1,tasks.size());
        System.assertEquals('Follow Up', tasks[0].Subject);
        System.assertEquals('Not Started', tasks[0].Status);
        
        
    }

}