trigger CustomRiskEvent on Customer_Risk_Event__e (after insert) {
    System.debug('trigger Fired');
    CustomRiskEventHandleEvents.handleEvents(Trigger.New);
    

}