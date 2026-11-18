trigger AccountTriggers on Account (before insert, before delete) {  
    if(Trigger.isInsert){
     AccountTriggersHandler.ExeceptingTestmethod(Trigger.new); 
    }
    if(Trigger.isDelete){
    AccountTriggersHandler.deleting(Trigger.old);

   }  
}