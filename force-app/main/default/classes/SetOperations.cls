public class SetOperations {
    public static Set<String>emailOfCustom(){
        Set<String>customEmails=new Set<String>();
            customEmails.add('mamathapamarthi04@gmail.com');
            customEmails.add('anithasheru@gmail.com');
            
        Set<String>newLead=new Set<String>();
            newLead.add('vyshu@04gmail.com');
            newLead.add('mamathapamarthi04@gmail.com');
                customEmails.retainAll(newLead);
        Set<String> result = new Set<String>(customEmails);
        result.retainAll(newLead);
        return result;
    } 
}