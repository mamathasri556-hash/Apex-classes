public class OpportunitytriggerHandler { 
    public static Void oppHandler(List<Opportunity>opps,Map<Id, Opportunity> oldMap){
        for(Opportunity opp : opps){
            Opportunity oldOpp = oldMap.get(opp.Id);
            if(oldOpp.StageName == 'Closed Won' && opp.Amount !=oldOpp.Amount){
                opp.Amount.addError('Amount cannot be changed once the Opportunity is Closed Won.');
            }
            
        }
    }

}