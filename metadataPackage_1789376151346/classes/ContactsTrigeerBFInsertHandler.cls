public class ContactsTrigeerBFInsertHandler { 
    public static void conditionTest(List<Contact>contacts){
        for(Contact con : contacts){ 
            if(con.Email == null){
                con.addError('Email is Required');
            }
        }
    }

}