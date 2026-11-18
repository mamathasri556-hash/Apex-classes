public class OpportunityTriBFUpHandler { 
    public static void testUpdateMethod(List<Opportunity> newopps, Map<Id, Opportunity>oldMap){
        for(Opportunity opp : newopps){
            Opportunity oldOpp = oldMap.get(opp.Id);
            if(opp.StageName == 'CLosed Won' && opp.Amount!=oldOpp.Amount){
                opp.Amount.addError('Amount cannot be chgaed');
              
            }
        }
    }

}