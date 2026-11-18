public class ContactsTriHandler { 
    public static Void DeletionLog(List<Contact> contacts){
        List<Deletion_Log_c__c> logs = new List<Deletion_Log_c__c>();
        for(Contact con : contacts){ 
            Deletion_Log_c__c log =  new Deletion_Log_c__c();
            log.Contactname__c = con.Name;
            logs.add(log);
        } 
        if(!logs.isEmpty()){
            insert logs;
        }
        
    }

}