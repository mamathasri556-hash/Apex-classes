public class DormatAccount implements Database.Batchable<Sobject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
       'SELECT Id, Name,Description FROM Account'
        );
    } 
    public void execute(Database.BatchableContext bc, List<Account> scope){
       System.debug('Records found:' + scope.size());
        for (Account acc: scope){
            acc.Description = 'Description was updated';
            
        } 
        update scope;
      
        
    }
    public void finish(Database.BatchableContext bc){
    
        System.debug('Batch completed'); 
    } 
        
    }