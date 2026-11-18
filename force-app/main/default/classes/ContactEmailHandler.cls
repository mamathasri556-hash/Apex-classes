public class ContactEmailHandler { 
    public static void checkDuplicate(List<Contact>cons,map<Id, Contact>oldmap){ 
        Set<String>email = new Set<String>();  
        for(Contact con : cons){ 
            if(String.isBlank(con.Email)){
                continue;
            } 
            List<Contact> existingContacts = [ 
                SELECT Id, Email 
                FROM Contact 
                WHERE Email = :con.Email AND Id != :con.Id
            ]; 
            if(!existingContacts.isEmpty()){
                con.Email.addError('Email alredy exists.');
            }
        } 
    } 
}