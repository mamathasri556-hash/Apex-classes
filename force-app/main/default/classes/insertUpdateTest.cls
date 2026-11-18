@isTest
public class insertUpdateTest {  
    @isTest
    public static void testInsertMethod(){
        List<Account> accountList = new List<Account>();
        accountlist.add(new Account(Name='ABC Crop',MyExternalId__c='Ex001'));
        List<Account> result =dmlinsertUpdate.updateInsert();
        System.assertNotEquals(0,result.size());
    }

}