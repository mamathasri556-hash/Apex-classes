public class AnimalsCallouts{
    Public static HttpResponse makeGetCallout(){
        Http http = new Http(); 
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint('https://th-apex-httpp-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode () == 200){
            Map<String, object> result = (map<String, object>)JSON.deserializeUntyped(response.GetBody());
            List<object> animals = (List<object>) result.get('animals'); 
            System.debug('Received the following animals:');
            for(object animal : animals){
                System.debug(animals);
            }
                
        } 
        return response;
    } 
    public static HttpResponse makePostCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint('http://th-apex-http-callout.herokuapp.com/aniamls');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() !=201){
            System.debug('The status code reeturned was not expected: '+ response.getStatusCode());
        }else{
            System.debug(response.getBody());
        } 
        return response;
        }
        
    }