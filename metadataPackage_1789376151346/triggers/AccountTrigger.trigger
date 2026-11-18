trigger AccountTrigger on Account (after insert) {
    HandlerAccount.AfterInsert(Trigger.new);

}