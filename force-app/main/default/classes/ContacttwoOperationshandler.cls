public class ContacttwoOperationshandler { 
    public static void getOneOpearation(List<Contact> cons){ 
        for(Contact con : cons){
            if(con.Department=='PCI'){
                con.Description='yes it was PCI';
            }
            
        }
        
    } 
    public static void getSecOperation(List<Contact> coms){
        List<Task>newList = new List<Task>();
        for(Contact con : coms){
            Task t = new Task(
                Subject = 'Follow Up',
                Status = 'Not Started',
                WhoId  = con.Id
            ); 
            newList.add(t);
        } 
        insert newList;
    }

}