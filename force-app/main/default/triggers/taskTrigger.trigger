trigger taskTrigger on Task (before insert, after insert, before update, after update, before delete, after delete) {

    // What happens when you change the order of these two triggers handlers?
    if (trigger.operationType == TriggerOperation.AFTER_INSERT)
    {
        taskSetStatus.handleTrigger(trigger.new);
    }

    if(trigger.operationType == TriggerOperation.AFTER_INSERT ||
        trigger.operationType == TriggerOperation.AFTER_UPDATE ||
        trigger.operationType == TriggerOperation.AFTER_DELETE)
    {
        taskTrackCount.handleTrigger(trigger.operationType, trigger.new, trigger.old);
    }


}