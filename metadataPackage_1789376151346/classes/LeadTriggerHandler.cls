public class LeadTriggerHandler { 
    public static void leadTestMethod(List<lead> newLeads,map<Id, Lead>oldMap){
        for(Lead ld : newLeads){
            Lead oldLead = oldMap.get(ld.Id);
            if(ld.Status != oldLead.Status){
                Task t = new Task(
                Subject = 'Follow UP',
                ActivityDate = Date.today(),
                Status = 'In Progress'
                );
                    
                }
                
            }
        }
    }