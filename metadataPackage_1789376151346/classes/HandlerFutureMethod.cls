public class HandlerFutureMethod { 
    @future(callout=true)
    public static void loAccountCreation(Set<Id> accountIds){
        HttpRequest req = new HttpRequest();
        req.setEndPoint('https://httpbin.org/post');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody('{"message":"Account created"}'); 
        System.debug('Response Body: ' + req.getBody());
        Http http = new Http(); 
        try{
            HttpResponse res = http.send(req);
            System.debug('Status Code ' + res.getStatusCode());
        }catch(Exception e){
            System.debug('Error:'+e.getMessage());
        }
        
    }

}