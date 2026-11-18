public class CustomRiskEventHandleEvents {
    public static void handleEvents(
        List<Customer_Risk_Event__e> events){
            System.enqueueJob(
            new CustomerRiskQueueable(events)
            );
        }

}