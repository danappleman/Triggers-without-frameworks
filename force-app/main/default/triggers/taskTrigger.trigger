trigger taskTrigger on Task (before insert, after insert, before update, after update, before delete, after delete) {

    simpleLeadUpdater leadUpdater = new simpleLeadUpdater();

    // What happens when you change the order of these two triggers handlers?
    if (trigger.operationType == TriggerOperation.AFTER_INSERT)
    {
        taskSetStatus.handleTrigger(trigger.new, leadUpdater);
    }

    if(trigger.operationType == TriggerOperation.AFTER_INSERT ||
        trigger.operationType == TriggerOperation.AFTER_UPDATE ||
        trigger.operationType == TriggerOperation.AFTER_DELETE)
    {
        taskTrackCount.handleTrigger(trigger.operationType, trigger.new, trigger.old, leadUpdater);
    }

    List<ITriggerExtension> dyanmicTriggers = TriggerExtensionSupport.getTriggerClasses('Task');
    for(ITriggerExtension trig: dyanmicTriggers)
    {
        trig.HandleTrigger(trigger.operationType, trigger.new, trigger.old, 
                            trigger.newMap, trigger.oldMap);
    }

    leadUpdater.updateLeads();

}