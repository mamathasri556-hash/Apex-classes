public class dmlinsertUpdate  { 
    public static List<Account>updateInsert(){ 
        List<Account>accountList=new List<Account>();
        accountList.add(new Account (Name='ABC Crop', MyExternalId__c = 'Ex001')); 
        accountList.add(new Account (Name = 'sri', MyExternalId__c = 'Ex002'));  
        accountList.add(new Account(Name = 'mammu', MyExternalId__c = 'Ex432')); 
        
        upsert accountList MyExternalId__c; 
        return accountList;
        
    }
    

}