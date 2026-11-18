public class AccountBatch implements Database.Batchable<Sobject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id, FROM Account');

}  
    public void execute(Database.BatchableContext bc, List<Account> scope){
       System.debug('Records found:' + scope.size());
} 
    public void finish(Database.BatchableContext bc){
    
        System.debug('Batch completed');  
        
    } 
    
}