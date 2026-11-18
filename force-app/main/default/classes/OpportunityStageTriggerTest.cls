@isTest 
public class OpportunityStageTriggerTest{
    @isTest
    public static void Taskcreted(){
        Opportunity opp = new Opportunity(
        Name = 'Test Opportunity',
        StageName = 'Prospecting',
        CloseDate=Date.today().addDays(20)
        ); 
        insert opp; 
        opp.StageName ='Closed Won';
        update opp; 
        List<Task> tasks = [ 
        SELECT Id, Subject, Status, WhatId
        FROM Task 
        WHERE WhatId = :opp.Id
        ]; 
        System.assertEquals(1, tasks.size());
    }
}