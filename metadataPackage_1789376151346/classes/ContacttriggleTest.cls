@isTest
public class ContacttriggleTest {
    @isTest
    public static void contTestMethod(){
        Contact con = new Contact(
        Lastname = 'sri'
        );

       Database.SaveResult result = Database.insert(con, true);
       System.assertEquals(true, result.isSuccess());
       System.assert(result.getErrors()[0].getMessage().contains('Email is required'),'Expected Email required error'
                    );
        
    }

}