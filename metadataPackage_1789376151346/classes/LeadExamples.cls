public class LeadExamples{ 
    /*
    public static void AdOfLead(){
        Lead l1 = new Lead(
        LastName = 'mamatha',
        Company = 'Abc'
        );
        Lead l2 = new Lead(
        LastName = 'sri',
        Company = 'Bc'
        ); 
        List<lead> leads = new List<Lead>{
            l1,
            l2
        }; 
        insert leads; 
        for(Lead Id: leads){
            System.debug(id.Id);
        }
    }*/ 
    public static List<Lead> updating(){
        List<Lead>leads = [
            SELECT Id, LastName, FirstName
            FROM Lead
            LIMIT 3
        ]; 
        for(Lead id : leads){
            Id.lastName = 'mamatha';
            Id.FirstName = 'sri';
        } 
           update leads;
               
          return leads;
    }
}