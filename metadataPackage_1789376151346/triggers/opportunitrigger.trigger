trigger opportunitrigger on Opportunity (before update) {
    OpportunitytriggerHandler.oppHandler(Trigger.new,
                                        Trigger.oldMap);

}