public class OpportunityStageTriggerHandler { 
    public static void checkStage(List<Opportunity>opps,map<Id, Opportunity>oldMap){   
        List<Task> task = new List<Task>();
        for(Opportunity opp : opps){
            Opportunity oldOpp = oldMap.get(opp.Id); 
            if(opp.StageName=='Closed Won' && oldOpp.StageName!='Closed Won'){   
                Task t = new Task(
                Status ='Not started',
                Subject='Email',
                WhatId=opp.Id
                ); 
                task.add(t);

            }
        } 
        if(!task.isEmpty()){
            insert task;
        }
        
        
    }

}