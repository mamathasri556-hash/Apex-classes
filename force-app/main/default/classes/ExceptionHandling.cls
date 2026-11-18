public class ExceptionHandling{
    public ExceptionHandling(){
        try { 
            Favorite__c  obj = new Favorite__c();
            obj.Name = 'mamatha';
            insert obj;
            
        } catch(DmlException e) { 
            System.debug(e.getMessage());
            
        } catch(Exception e){
            System.debug(e.getMessage());
        }
        
        finally{
            System.debug('complted');
                }
    }  
    public static void testExceptionHandlingmethod(){
        ExceptionHandling obj = new ExceptionHandling();
    }
}