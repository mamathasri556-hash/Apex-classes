public class ContactTriggerHandler { 
    public static void ValidateEmail(List<Contact> contacts){
        for(Contact con : contacts){
            if(String.isBlank(con.Email)){
                con.Email.addError('Email is required.');
            }
        }
    }
}