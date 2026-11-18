@isTest
public class AccountTriggerMockCallout implements HttpCalloutMock { 
    public  HttpResponse respond(httpRequest req){
        HttpResponse res = new HttpResponse ();
        res.setStatusCode(200);
        res.setBody('{"status":"successs"');
        return res;
    }

}