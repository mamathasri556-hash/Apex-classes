public class AccountCalculation implements Database.Batchable<Sobject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id, Name FROM Account WHERE Active__c = \'true\''
        );  
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){ 
        System.debug('records' + scope.size());
        //*getting the id of the activie account in one list*//
        List<Id> accountIds = new List<Id>();
        for(Account acc: scope){
            accountIds.add(acc.Id);
        } 
        List<Opportunity> opportunities = [ 
            SELECT Id, AccountId, StageName, CLoseDate, Amount
            FROM Opportunity 
            WHERE AccountId In: accountIds
            AND StageName = 'Closed Won' And CloseDate = Last_N_MONTHS: 12
        ];
        Decimal totalRevenue = 0; 
        for(Opportunity opp: opportunities){
            totalRevenue = totalRevenue+ opp.Amount;
            System.debug('totoalClosed Won revenue' + totalRevenue);
            
        }  
        List<Opportunity> openOpportunities = [ 
            SELECT Id, AccountId, Amount FROM Opportunity  WHERE AccountId IN :accountIds AND IsCLosed = false ]; 
        Decimal openOpportunity = 0; 
        for(Opportunity opp : openOpportunities){
            if(opp.Amount != null){
                openOpportunity = openOpportunity + opp.Amount;
            }
        }
        List<Case> cases = [
            SELECT Id, AccountId, CreatedDate
            FROM Case
            WHERE  Accountid IN :accountIds AND CreatedDate = Last_N_Days:90
        ];  
        cases.size();
        Integer HighPriorityCases = 0;
        for(Case css: cases){
            if((css.Status == 'new' || css.Status == 'Working' || css.status == 'Escalated')&&(css.Priority=='High')){
                HighPriorityCases++;
            }
        } 
        List<Task> task = [ 
            SELECT WhatId, AccountId, Subject,Status,ActivityDate
            FROM Task
            WHERE WhatId IN:accountIds And Subject ='Follow Up' AND Status ='Completed'
        ];
        Date lastDate;
        for(Task t : task){
            if(lastdate == null || t.ActivityDate > lastDate){
                lastDate = t.ActivityDate;
            }
        } 
        
        List<Contract> contracts = [
            SELECT Id,AccountId, EndDate
            FROM Contract
            WHERE AccountId IN :accountIds
        ];  
        Date lastestEndDate; 
        for(Contract c: contracts){
            if(lastestEndDate == null || c.EndDate > LastestEndDate){
                lastestEndDate = c.EndDate;
            } 
        } 
        //*custom risk*//
        Integer riskScore = 0; 
        if(cases.size()>5){
            riskScore = riskScore+20;
        } 
        if(HighPriorityCases>0){
            riskScore = riskScore+25;
        } 
        if(totalRevenue>500000){
            riskScore = riskScore - 15;
        }  
        /*daysBetween means it was fucntion which tell the end to today middles**/
        Integer lastDay = lastDate.daysBetween(Date.today());
        if (lastDay == null){
            riskScore = riskScore + 20;
        } 
        if(openOpportunity > 100000){
            riskScore = riskScore - 10;
        } 
        if(totalRevenue> 500000){
            riskScore =riskScore  - 15;
            
        }  
        if(lastDate== null){
            riskScore  = riskScore+ 20;
        }else{
            Integer lastDays = lastDate.daysBetween(Date.today());
            if(lastDays>60){
                riskScore = riskScore + 20;
            }
        }
        
        if(lastestEndDate != null){
            Integer endDay = Date.today().daysBetween(lastestEndDate);
            if(endDay >=0 && endDay<=30){
                riskScore = riskScore+ 30;
            }
        } 
        String AccountRiskLevel;
        if(riskScore>=0&& riskScore<=19){
            AccountRiskLevel ='Low';
        }else if(riskScore >=20 && riskScore<=39){
            AccountRiskLevel = 'medium';
        }else if(riskScore >=40 && riskScore<=59){
            AccountRiskLevel = 'High';
        }else{
            AccountRiskLevel = 'Critical';
        } 
        for(Account acc : scope){
            acc.AccountRiskLevel__c = AccountRiskLevel;
        } 
        update scope;
       } 

public void finish(Database.BatchableContext bc){
    
    System.debug('Batch completed'); 
} 


}