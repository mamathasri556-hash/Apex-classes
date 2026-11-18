public class AccountRisk implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator(
            'SELECT Id, Name, Risk_Level__c, OwnerId,Total__c FROM Account WHERE Active__c =\'Yes\''
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Account> scope){
        
        System.debug('Accounts Found: ' + scope.size());
        
        Map<Id, Account> accountMap = new Map<Id, Account>();

        for(Account acc : scope){
            accountMap.put(acc.Id, acc);
        }
        
        Set<Id> accIds = accountMap.keySet();
        System.debug('accIds = ' + accIds);
        System.debug('accIds Size = ' + accIds.size());
        
        List<Opportunity> opportunities = [
            SELECT Id, Name, StageName, AccountId, Amount
            FROM Opportunity
            WHERE AccountId IN :accIds
            AND StageName = 'Closed Won'
            AND CloseDate >= :Date.today().addMonths(-12)
        ];
        
        System.debug('Opportunities Found: ' + opportunities.size());
        
        Map<Id, Decimal> oppMap = new Map<Id, Decimal>();
        
        for(Opportunity opp : opportunities){
            
            if(!oppMap.containsKey(opp.AccountId)){
                oppMap.put(opp.AccountId, 0);
            }
            
            Decimal amount = (opp.Amount == null) ? 0 : opp.Amount;
            
            oppMap.put(
                opp.AccountId,
                oppMap.get(opp.AccountId) + amount
            );
            
            System.debug(
                'Account Id: ' + opp.AccountId +
                ' Amount: ' + amount +
                ' Total Revenue: ' + oppMap.get(opp.AccountId)
            );
            
            
            System.debug('Final Revenue Map: ' + oppMap);  
            System.debug('Accounts Found: ' + scope.size());
            System.debug('Opportunities Found: ' + opportunities.size());  
        }  
        System.debug('accIds = ' + accIds);
        System.debug('accIds Size = ' + accIds.size());
        System.debug('Account Ids = ' + accIds);
        List<Opportunity> openOpp  =[
            SELECT Id, AccountId, Amount
            FROM Opportunity
            WHERE AccountId IN : accIds
            AND IsClosed = false
        ];  
        Map<Id, Decimal>amount=new Map<Id, Decimal>();
        for(Opportunity opp : openOpp){
            if(opp.Amount !=null){
                if(!amount.containsKey(opp.AccountId)){
                    amount.put(opp.AccountId,0);
                } 
                amount.put(opp.AccountId,amount.get(opp.AccountId)+opp.Amount);
                System.debug(opp.AccountId +'  '+amount.get(opp.AccountId));
            }
        }  
        System.debug('Open Opportunities Found = ' + openOpp.size());
        System.debug('Open Opportunities = ' + openOpp);
        System.debug('accIds = ' + accIds);
        System.debug('accIds Size = ' + accIds.size());
        list<Case> countcase = [
            SELECT Id,AccountId, CreatedDate, status
            FROM Case
            WHERE AccountId IN : accIds  AND CreatedDate >= :Date.today().addDays(-90)
        ];  
        Map<Id,Integer>caseMap=new Map<Id, Integer>();
        for(Case css:countcase){
            if(!caseMap.containsKey(css.AccountId)){
                caseMap.put(css.AccountId,0);
                
            } 
            caseMap.put(
                css.AccountId,caseMap.get(css.AccountId)+1);
            System.debug('Cases Found = ' + countcase.size());
            System.debug('Cases = ' + countcase);
        } 
        System.debug(countcase);  
        System.debug('Cases Found = ' + countcase.size());
        System.debug('Cases = ' + countcase);
        
        List<Case> highPriorityCases = [
            SELECT Id,AccountId, status, Priority
            FROM Case
            WHERE AccountId IN : accIds  AND Priority = 'High'
            AND Status !='Closed'
        ];    
        List<Case> allCases = [
            SELECT Id, CaseNumber, Priority, Status
            FROM Case
            WHERE AccountId IN :accIds
        ];
        
        System.debug('All Cases = ' + allCases);
        Map<Id, Integer>highPriorityMap=new Map<Id, Integer>();
        System.debug('High Priority Cases Size = ' + highPriorityCases.size());
        for(Case cs:highPriorityCases){
            if(!highPriorityMap.containsKey(cs.AccountId)){
                highPriorityMap.put(cs.AccountId,0);
                
            } 
            highPriorityMap.put(
                cs.AccountId,highPriorityMap.get(cs.AccountId)+1); 
            System.debug(highPriorityMap); 
        }   
        System.debug('High Priority Cases Size = ' + highPriorityCases.size());
        System.debug('High Priority Cases = ' + highPriorityCases);
        System.debug('accIds = ' + accIds);
        System.debug('accIds Size = ' + accIds.size()); 
        
        List<Task> followUpTask = [ 
            SELECT Id, Subject, WhatId, Status, ActivityDate
            FROM Task 
            WHERE WhatId IN : accIds
            AND Subject = 'Follow Up'
            AND Status = 'Completed'
        ]; 
        System.debug('Follow Up Tasks Found = ' + followUpTask.size());
        System.debug('Follow Up Tasks = ' + followUpTask);
        Map<Id, Date> followUpMap = new map<Id, Date>();
        for(Task t: followUpTask){
            if(!followUpMap.containsKey(t.WhatId) || t.ActivityDate > followUpMap.get(t.WhatId)){
                followUpMap.put(t.WhatId, t.ActivityDate);
            }
            
        }   
        
        System.debug('Follow Up Map ='+ followUpMap);
        
        List<Contract>contracts =[
            SELECT Id,AccountId, endDate__c
            FROM Contract
            WHERE AccountId IN :accIds
        ]; 
        System.debug('Contracts Found = ' + contracts.size());
        System.debug('Contracts = ' + contracts);
        Map <Id, Date>latestContractMap = new Map<Id, Date>();
        for(Contract c:contracts){
            if(!latestContractMap.containsKey(c.AccountId)){
                latestContractMap.put(c.AccountId, c.endDate__c);
            } 
            else if(c.endDate__c> latestContractMap.get(c.AccountId)){
                latestContractMap.put(c.AccountId, c.endDate__c);
            } 
            
        } 
        System.debug('Latest Contract Map = '+ latestContractMap); 
        
        for(Account acc :scope){
            Integer riskScore = 0;  
            if(latestContractMap.containsKey(acc.Id)){
                Integer days = 
                    Date.today().daysBetween(
                    latestContractMap.get(acc.Id)); 
                if(days <=30){
                    riskScore += 30;
                }
            }
    
            
            
            
            if(oppMap.containsKey(acc.Id)&&oppMap.get(acc.Id)>500000){
                riskScore -= 15;
            }  
            if(amount.containsKey(acc.Id)&&amount.get(acc.Id)>100000){
                riskScore -=10;
            }
            
            if(caseMap.containsKey(acc.Id)&&caseMap.get(acc.Id)>5){
                riskScore +=20;
            } 
            if(highPriorityMap.containsKey(acc.Id)&&highPriorityMap.get(acc.Id)>0){
                riskScore +=25;
            }  
        
            if(!followUpMap.containsKey(acc.Id)||followUpMap.get(acc.Id).daysBetween(Date.today())>60){
                riskScore +=20; 
            }
                
                
                
                if(riskScore>=0 && riskScore<=19){
                    acc.Risk_Level__c = 'Low';
                } 
                if(riskScore>=20 && riskScore<=39){
                    acc.Risk_Level__c = 'Medium';
                } 
                if(riskScore>=40 && riskScore<=59){
                    acc.Risk_Level__c = 'High';
                } 
                if(riskScore >= 60){
                    acc.Risk_Level__c = 'Critical';
                } 
              
            acc.Total__c= riskScore; 
              
            System.debug('Risk Score = ' + riskScore);
            System.debug('Risk Level = ' + acc.Risk_Level__c); 
        }    
        update scope;   
 
        List<Task> duplication = [ 
            SELECT Id, WhatId
            FROM Task
            WHERE WhatId IN :accIds
        ]; 
        Set <Id> taskAccountIds = new Set<Id>(); 
        for(Task t : duplication){
            taskAccountIds.add(t.WhatId);
        }
        List<Task> taskTOInsert = new List<Task>(); 
        for(Account acc :scope){ 
            if((acc.Risk_Level__c == 'High') || (acc.Risk_Level__c == 'Critical')&& !taskAccountids.contains(acc.Id)){
                
                
                taskTOInsert.add( 
                    new Task(
                        Subject = 'Follow Up',
                        status = 'Not Started',
                        priority = 'High',
                        WhatId = acc.Id,
                        ownerid = acc.OwnerId));
                
            }  
        }
            for(Account acc:scope){
                if(acc.Risk_Level__c == 'Critical'){
                    Customer_Risk_Event__e	event = new Customer_Risk_Event__e(
                        Account_Id__c = String.valueOf(acc.Id),
                        Owner_Id__c	 = String.valueOf(acc.OwnerId),
                        Risk_Level__c = acc.Risk_Level__c,
                        Risk_Score__c = acc.Total__c
                        );
                     Database.SaveResult sr = EventBus.publish(event);
                    if(sr.isSuccess()){
                        System.debug('Platfrom Event Publish Successfully');
                    } else{
                        for(Database.Error err : sr.getErrors()){
                            System.debug('Error:' + err.getMessage());
                        }
                    }
                    
                }
            }
    
    
       if(!taskTOInsert.isEmpty()){
          insert taskTOInsert;
    } 
    }

    
    public void finish(Database.BatchableContext bc){
        System.debug('Batch completed');
    }
}