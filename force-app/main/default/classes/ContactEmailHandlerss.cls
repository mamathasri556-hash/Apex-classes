public class ContactEmailHandlerss { 
    public static void getEmail(List<Contact>cons,map<Id,Contact>oldMap){
        for(Contact con : cons){
            Contact oldRecords = oldMap.get(con.Id);
                if(con.Email != oldRecords.Email){
                    ContactEmail__c newEmails = new ContactEmail__c ();
                    List<ContactEmail__c> emailList = new List<ContactEmail__c>();


                    }
                    
                }
            }
            
}