@isTest
public class AccountRiskTest {
    @isTest
    public  static void BatchRevenueTestMethod(){
        Account acc1 = new Account(
            Name = 'sri',
            Active__c = 'Yes'
        );  
        insert acc1;
        Opportunity opp1 = new Opportunity(
            Name='opp1',
            AccountId = acc1.Id,
            StageName ='Closed Won',
            CloseDate = Date.today(),
            Amount = 100000
        ); 
        Opportunity opp2 =new Opportunity(
            Name = 'Opp2',
            AccountId = acc1.Id,
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            Amount = 200000
        ); 
        insert new List<Opportunity>{opp1, opp2};
            Test.startTest();
        Database.executeBatch(
            new AccountRisk(),200);
        Test.stopTest();
        
        Integer oppCount= [
            SELECT Count()
            FROM Opportunity
            WHERE AccountId = :acc1.Id
        ];
        
        System.assertEquals(2, oppCount,'both contain values');
        
    }
    @isTest
    public static void BatchRevenuecheckingTestMethod(){
        Account acc3 = new Account(
            Name = 'sriu',
            Active__c = 'Yes'
        ); 
        insert acc3;
        Test.startTest();
        Database.executeBatch(new AccountRisk(),200);
        Test.stopTest();
        Integer accCount = [ 
            SELECT Count()
            FROM Account 
            WHERE Id = :acc3.Id
        ];
        System.assertEquals(1,accCount);
    }      
    
    @isTest
    public static void BatchRevenuecheckingtwoTestMethod(){
        
        Account acc4 = new Account(
            Name='ram',
            Active__c='Yes'
        );
        insert acc4;
        
        Opportunity opp = new Opportunity(
            Name='Opp',
            AccountId=acc4.Id,
            StageName='Closed Won',
            CloseDate=Date.today()   
        );
        insert opp;
        Test.startTest();
        database.executeBatch(new AccountRisk(),200);
        Test.stopTest();
        Integer oppCount = [ 
            SELECT Count() 
            FROM Opportunity 
            WHERE AccountId = :acc4.Id
        ];
        System.assertEquals(1,oppCount);  
    }   
    @isTest
    public static void OpportunityQueryConditionTestMethod() {
        
        Account acc = new Account(
            Name = 'Query Test',
            Active__c = 'Yes'
        );
        insert acc;
        
        Opportunity opp = new Opportunity(
            Name = 'Query Opp',
            AccountId = acc.Id,
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            Amount = 50000
        );
        insert opp;
        
        List<Opportunity> oppList = [
            SELECT Id
            FROM Opportunity
            WHERE AccountId = :acc.Id
        ];
        
        System.assertEquals(1, oppList.size());
        
    } 
    @isTest
    public static void OpportunityvalueTestMethod(){
        Account acc5 = new Account(
            Name = 'mamathasri', 
            Active__c = 'Yes'
        ); 
        insert acc5;
        list<Opportunity> oppList= new List<Opportunity>();
        oppList.add(new Opportunity(
            Name='opp1',
            AccountId = acc5.Id,
            StageName='Prospecting',
            CloseDate = Date.today().addDays(20),
            Amount = 10000));
        oppList.add(new Opportunity
                    (
                        Name='opp2',
                        AccountId = acc5.Id,
                        StageName='anegotiation/Review',
                        CloseDate = Date.today().addDays(20),
                        Amount = 20000)
                   ); 
        insert oppList;
        Test.startTest();
        Database.executeBatch(new AccountRisk(), 200); 
        Test.stopTest();
        Integer result = [
            SELECT COUNT()
            FROm Opportunity
            WHERE AccountId =:acc5.Id AND IsClosed = false
        ]; 
        System.assertEquals(2,result,'both are same');
    }  
    @isTest
    public static void casesCountTestmethod(){
        Account acc = new Account(
            Name = 'casetest',
            Active__c = 'Yes'
        );
        insert acc; 
        List<Case> caseList = new List<Case>();
        caseList.add(new case(
            Subject = 'case1',
            AccountId = acc.Id,
            Status = 'New' 
        ));
        caseList.add(new Case(Subject = 'case2',AccountId = acc.Id,Status = 'New')); 
        insert caseList;  
        System.assertNotEquals(null, caseList[0].Id);
        System.assertNotEquals(null, caseList[1].Id);
        
        
        Test.startTest();
        Database.executebatch(new AccountRisk(), 200);
        Test.stopTest();
        Integer result = [ 
            SELECT COUNT() FROM Case WHERE AccountId = :acc.Id AND (Status = 'New' OR Status = 'working')];
        System.assertEquals(2,result);
        
    } 
    @isTest
    public static void HighTestMethod(){
        Account acc = new Account(
            Name = 'mammu',
            Active__c = 'Yes'
        ); 
        insert acc; 
        List<Case> highList = new List<Case>();
        highList.add(new case(
            Subject = 'Low case',
            AccountId = acc.Id,
            Priority = 'Medium',
            status = 'New'));
        highList.add(new case(
            Subject = 'Low',
            Accountid = acc.Id,
            Priority = 'High',
            status = 'Working'
        ));
        highList.add(new case(
            Subject='mam',
            Accountid = acc.Id,
            Priority = 'low',
            status = 'Escalated'));
        insert highList; 
        List<Case> checkCases = [
            SELECT Id, Priority, Status
            FROM Case
            WHERE AccountId = :acc.Id
        ]; 
        List<Contract> checkContracts = [
            SELECT Id, AccountId, endDate__c
            FROM Contract
            WHERE AccountId = :acc.Id
        ];
        
        System.debug('Check Contracts = ' + checkContracts);
        System.debug('Check Contracts Count = ' + checkContracts.size()); 
        List<Case> testCases = [
            SELECT Id, AccountId, Priority, Status
            FROM Case
            WHERE AccountId = :acc.Id
        ];
        
        System.debug('TEST CASE COUNT = ' + testCases.size());
        System.debug('TEST CASES = ' + testCases);
        
        
        System.debug('Case Count = ' + checkCases.size()); 
        System.assertEquals(3, checkCases.size());
        Test.startTest();
        Database.executebatch(new AccountRisk(), 200);
        Test.stopTest(); 
        Integer highCaseCount = [ 
            SELECT COUNT() 
            FROM Case 
            WHERE AccountId = :acc.Id 
            AND priority = 'High'
        ];
        
        System.debug('High Cases = ' + highList);
        System.debug('High Case Count = '+ highList.size());
        System.assertEquals(0,highCaseCount);
    } 
    @isTest
    public static void FollowUpTestMethod(){
        Account acc = New Account(
            Name = 'mamatha',
            Active__c = 'Yes');
        insert acc; 
        Task followUp = new Task(
            Subject = 'Follow Up',
            Status = 'completed',
            ActivityDate = Date.today().addDays(10),
            WhatId = acc.Id,
            OwnerId = UserInfo.getUserId()); 
        insert followUp;
        Task followUp1= new Task(
            Subject = 'Follow Up',
            status = 'Completed',
            ActivityDate = Date.today().addDays(-10),
            Whatid = acc.Id, 
            OwnerId = UserInfo.getUserId());
        insert followUp1;
        Task result = [ 
            SELECT Id, Subject, Status, ActivityDate, WhatId 
            FROM Task 
            WHERE WHATID = :acc.Id
            AND Subject = 'Follow Up'
            LIMIT 1];    
        Test.startTest();
        Database.executeBatch(new AccountRisk(),200);
        Test.stopTest();
        
        System.assertEquals('Follow Up',result.Subject);
        System.assertEquals('Completed',result.Status);
        System.assertEquals(acc.Id,result.WhatId);   
        
    } 
    @isTest
    Public static void contractTestMethod(){
        Account acc = new Account(
            Name = 'Mam',
            Active__c = 'Yes'
        );  
        insert acc;
        Contract contract1 = new Contract( 
            AccountId = acc.Id,
            StartDate = Date.today(),
            endDate__c= Date.today().addDays(5),
            Status = 'Draft'
        );
        Contract contract2 = new Contract(
            Accountid = acc.Id,
            StartDate = Date.today(),
            endDate__c = Date.today().addDays(15),
            Status = 'Draft'
        );  
        Contract contract3 = new Contract(
            AccountId = acc.Id,
            StartDate = Date.today(),
            endDate__c = date.today().addDays(20),
            Status = 'Draft'); 
        insert new List<Contract>{
            contract1,
                contract2,
                contract3
                }; 
                    List<Contract> contracts = [
                        SELECT Id, AccountId,endDate__c,StartDate,Status,OwnerId
                        FROM Contract 
                        WHERE AccountId = :acc.Id 
                    ];   
        
        Test.startTest();
        Database.executeBatch(new AccountRisk(), 200);
        Test.stopTest(); 
        Contract con = [
            SELECT Id, endDate__c
            FROM Contract
            WHERE AccountId = :acc.Id
            LIMIT 1
        ];
        
        System.debug('Contract Date = ' + con.endDate__c);
        System.assertEquals(3,contracts.size());
        
    } 
    
}