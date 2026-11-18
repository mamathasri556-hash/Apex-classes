public class Pages{
    public Opportunity opp {get;set;}
    public List<OpportunityLineItem> opps {get;set;} 
    public Pages(ApexPages.StandardController controller){
        Id oppId = ApexPages.currentPage()
                             .getParameters()
                             .get('id'); 
        opp = [ 
        SELECT Id, 
        Name,Amount
        FROM Opportunity 
        WHERE Id = :OppId  
        LIMIT 1
        ]; 
        opps = [ 
        SELEct Id,Quantity,UnitPrice,TotalPrice,PricebookEntry.Product2.Name
        FROM OpportunityLineItem 
        WHERE OpportunityId = :OppId]; 
        
    }
}