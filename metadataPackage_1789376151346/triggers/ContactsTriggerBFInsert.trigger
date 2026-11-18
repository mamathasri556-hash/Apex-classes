trigger ContactsTriggerBFInsert on Contact (before insert) {
    ContactsTrigeerBFInsertHandler.conditionTest(Trigger.new);

}