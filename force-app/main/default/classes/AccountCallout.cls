public class AccountCallout { 
    @future(callout=true)
    public static void logAccountCreation(Set<Id> accountIds){
        System.debug('Future Method Started');
        HttpRequest req = new HttpRequest();
        req.setEndPoint('https://httpbin.org/post');
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody('{"message":"Account created"}'); 
        Http http = new Http(); 
        try{
            HttpResponse res = http.send(req);
            System.debug('Status Code: '+ res.getStatusCode());
            System.debug('Response:' + res.getBody());
        }catch(Exception e){
            System.debug('Error'+ e.getMessage());
        }
        
    }

}