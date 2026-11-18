@isTest
public class UpdateOpportunitiesTest {

    @isTest
    public static void testOpportunitiesMethod() {
        Opportunity opp = new Opportunity(
        Name = 'Test Opp',
        StageName = 'Closed Won',
        CloseDate = Date.today()
        ); 
        insert opp;
        System.debug('Opportunity OwnerId: ' + opp.OwnerId);
        List<Opportunity> opps = new List<Opportunity>();
        opps.add(opp);
        updateTasks.createFollowUp(opps);
        List<Task> tasks = [
            SELECT Id
            FROM Task 
            WHERE WhatId = :opp.Id
        ];

        System.assertEquals(1, tasks.size(),'Task was created');
         
    }
}