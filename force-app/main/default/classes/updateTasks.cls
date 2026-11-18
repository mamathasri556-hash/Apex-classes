public class updateTasks{
    
        public static void createFollowUp(List<Opportunity>opps) {
              
            Set<Id> oppIds = new Set<Id>();
    
            for (Opportunity opp : opps) {
                if(opp.StageName == 'Closed Won'){
                oppIds.add(opp.Id);
            } 
             
           }  
            if(oppIds.isEmpty()){
                return ;
            }
    
            List<Task> existingTasks = [
                SELECT Id, WhatId, Subject
                FROM Task
                WHERE WhatId IN :oppIds
                AND Subject = 'Follow Up'
            ];
    
            Set<Id> oppsWithTasks = new Set<Id>();
    
            for (Task t : existingTasks) {
                oppsWithTasks.add(t.WhatId);
            }
    
            List<Task> taskList = new List<Task>();
    
            for (Opportunity opp : opps) {
    
                if (opp.StageName == 'Closed Won' &&
                    !oppsWithTasks.contains(opp.Id)) {
    
                    Task t = new Task();
                    t.Subject = 'Follow Up';
                    t.Status = 'Not Started';
                    t.ActivityDate = opp.CloseDate;
                    t.WhatId = opp.Id;
    
                    taskList.add(t);
                }
            }
    
            if (!taskList.isEmpty()) {
                insert taskList;
            }
        }
    }