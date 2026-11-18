public class CustomerRiskQueueable implements Queueable,Database.AllowsCallouts{
    
    private List<Customer_Risk_Event__e> events;
    
    public CustomerRiskQueueable(List<Customer_Risk_Event__e> events){
        this.events = events;
    } 
    
    public void execute(QueueableContext qc){
        System.debug('Queueable Started');
        System.debug('Events = ' + events.size());
        for(Customer_Risk_Event__e e : events){ 
  
            Map<String,object> payload = new Map<String,object>();
            payload.put('accountId', e.Account_Id__c);
            payload.put('ownerId',e.owner_Id__c);
            payload.put('riskLevel',e.Risk_level__c);
            payload.put('riskScore',e.Risk_Score__c);
            String jsonBody = JSON.serialize(payload);
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://httpbin.org/post');
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setBody(jsonBody);

            
         
        
        try{
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('Status Code = '+ res.getStatusCode());
            System.debug('Response = ' + res.getBody()); 
            if(res.getStatusCode() == 200){
                System.debug('Callout Succesful');
            } 
            else{
                System.debug('Callout Failed');
            }
        } 
        catch(Exception ex){
            System.debug('Callout Error = ' + ex.getMessage());
        } 
        }
        
        
    } 
    
}