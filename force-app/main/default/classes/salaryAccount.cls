public class salaryAccount implements Database.Batchable<Sobject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
        'SELECT Id, Site FROM Account');
    } 
    public void execute(Database.BatchableContext bc, List<Account> varible){
        for(Account acc: varible){
            acc.Site='sri'; 
        } 
        update varible;
    }  
    public void finish(Database.BatchableContext bc){
        System.debug('done');
    }
}