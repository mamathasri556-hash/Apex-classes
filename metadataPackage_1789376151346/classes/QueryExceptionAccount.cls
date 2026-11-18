public class QueryExceptionAccount {
    public QueryExceptionAccount(){
     try{
       Account acc = [ 
        SELECT Id,Name
        FROM Account
        WHERE MyExternalId__c ='Ex101'
        ];
    } 
        catch(QueryException e){
            System.debug('Account was not found'+e.getMessage());
        } 
        
        finally{
            System.debug('Query completed');
            
        }
        
        
    }
        
    }