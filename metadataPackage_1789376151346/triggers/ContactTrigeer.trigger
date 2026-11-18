trigger ContactTrigeer on Contact (after delete) {
    ContactsTriHandler.DeletionLog(Trigger.old);

}