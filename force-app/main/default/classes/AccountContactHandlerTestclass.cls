@isTest
public class AccountContactHandlerTestclass {  
    @isTest
    public static void testAccountWithContact(){
        Account acc = new Account( 
        Name = 'sri'); 
        insert acc; 
        Contact con = new Contact(
        LastName = 'sriu',
        Email = 'mamatha@gmail.com',
        AccountId = acc.Id); 
        insert con; 
        Test.startTest();
        AccountContactDeleteHandler.getdata(new List<Account> {acc}); 
        Test.stopTest();
        System.assertEquals(true, acc.hasErrors());
        System.assertEquals(
        'Connot be deleted is Account Contact was conneted', acc.getErrors()[0].getMessage());
    }

}