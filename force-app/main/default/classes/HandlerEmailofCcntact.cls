public class HandlerEmailofCcntact {
    public static void getEmails(List<Contact>cons, map<id,Contact>oldMap){ 
        List<ContactEMail__c>emailList = new List<ContactEMail__c>();
        for(Contact con : cons){
            Contact oldRecords = oldMap.get(con.Id);
            if(con.Email != oldRecords.Email){
                ContactEMail__c emails = new ContactEMail__c();
                emails.OldEmail__c = oldRecords.Email;
                emails.NewEmail__c = con.Email;
                emailList.add(emails);
            } 
            
            
            
        }
if(!emailList.isEmpty()){
    insert emailList;
} 

} 
}