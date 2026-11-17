public class AccOppTrigQueueJob implements Queueable{ 
    private Set<Id> accountIds;
    public AccOppTrigQueueJob(Set<Id> accountIds){
        this.accountIds = accountIds;
    } 
    public void execute(QueueableContext qc){
        List<Opportunity> oppList = [ 
        SELECT Id, Description 
        FROM Opportunity 
        WHERE AccountId IN : accountIds
        ]; 
        Integer countOpps = 0; 
        for(Opportunity opp : oppList){
            opp.Description = 'Updated';
            countOpps++;
        } 
        if(!oppList.isEmpty()){
            update oppList;
        } 
        
    }
}