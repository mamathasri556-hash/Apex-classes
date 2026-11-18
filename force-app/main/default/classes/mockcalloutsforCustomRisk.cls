@isTest
public class mockcalloutsforCustomRisk implements httpCalloutMock { 
   public  HttpResponse respond(HttpRequest req){
        
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"status":"Success"}');
        
        return res;
        
    } 
}