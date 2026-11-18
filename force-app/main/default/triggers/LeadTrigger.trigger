trigger LeadTrigger on Lead (After update) {
    LeadTriggerHandler.leadTestMethod(Trigger.new,
                                     Trigger.oldMap);

}