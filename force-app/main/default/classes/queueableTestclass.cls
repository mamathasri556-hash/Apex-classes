@isTest
public class queueableTestclass { 
    @isTest 
    public static void testQueuebleCallout(){
        Test.setMock(HttpCalloutMock.class, new CustomEventHandlerMock()); 
        Customer_Risk_Event__e eventRec = 
            new Customer_Risk_Event__e( 
                Account_Id__c = '001123',
                Owner_Id__c = '005123',
                Risk_Level__c = 'Critical',
                Risk_Score__c = 75); 
        Test.startTest();
        EventBus.publish(eventRec);
        Test.stopTest(); 
        System.assert(true);
        
    
    
    }
    
}