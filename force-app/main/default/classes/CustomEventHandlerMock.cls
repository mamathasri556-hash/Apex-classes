@isTest
public class CustomEventHandlerMock implements HttpCalloutMock { 
    public HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
        res.setBody('{"message":"Success"}');
        return res;
    }

}