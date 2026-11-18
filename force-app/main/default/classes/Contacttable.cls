public class Contacttable { 
    @AuraEnabled(cacheable=True)
    public static list<Contact> getContact(){ 
        return [ 
        SELECT Id, AccountId,AssistantName,CleanStatus
        From Contact  
        LIMIT 40
        ];
    }

}