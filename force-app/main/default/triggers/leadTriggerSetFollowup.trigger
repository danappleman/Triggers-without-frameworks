trigger leadTriggerSetFollowup on Lead (after insert, after update) {

    // leads created as 'Working - Contacted' or with status updated to 'Working - Contacted'
    // have a 'Lead followup' task created.

    List<Lead> leadsToProcess = new List<Lead>();

    for(Lead ld: trigger.new)
    {
        if(ld.status == 'Working - Contacted' &&
            (trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(ld.id).status != 'Working - Contacted')))
        {
            system.debug('leadTriggerSetFollowup: Current lead status = ' + ld.status + ' lead: ' + ld.id);
            if(trigger.isUpdate) system.debug('leadTriggerSetFollowup: Prior lead status = ' + trigger.oldMap.get(ld.id).status + + ' lead: ' + ld.id);
            leadsToProcess.add(ld);
        }
    }
    if(leadsToProcess.size()==0) return;

    List<Task> newTasks = new List<Task>();
    for(Lead ld: leadsToProcess)
    {
        Task newTask = new Task(ActivityDate = Date.Today().addDays(3),
                        Description = 'Make sure lead has been looked at',
                        Subject = 'Lead followup',
                        Type = 'Other',
                        WhoID = ld.id);
        newTasks.add(newTask);
    }
    insert newTasks;

}