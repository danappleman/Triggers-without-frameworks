trigger taskTriggerTrackCount on Task (after insert, after update, after delete) {
    Set<ID> leadIds = new Set<ID>();

    if(trigger.isUpdate || trigger.isInsert)
    {
        for(Task t: trigger.new)
        {
            if(t.whoId!=null && t.whoID.getSObjectType()==Schema.Lead.SObjectType) leadIds.add(t.whoId);
        }
    }
    if(trigger.isUpdate || trigger.isDelete)
    {
        for(Task t: trigger.old)
        {
            if(t.whoId!=null && t.whoID.getSObjectType()==Schema.Lead.SObjectType) leadIds.add(t.whoId);
        }

    }

    List<Lead> leads = [Select ID, Task_Count__c from Lead where ID in :leadIds];

    List<AggregateResult> tasks = [Select Count(ID) items, WhoId from Task where WhoId in :leadIds group by WhoID];
    Map<ID, Integer> taskCounts = new Map<ID, Integer>();

    for(AggregateResult ar: tasks)
    {
        taskCounts.put((ID)ar.get('WhoId'), (Integer)ar.get('items'));
    }

    List<Lead> leadsToUpdate = new List<Lead>();
    for(Lead ld: leads)
    {
        if(ld.Task_Count__c != taskCounts.get(ld.Id))
        {
            ld.Task_Count__c = taskCounts.get(ld.id);
            system.debug('taskTriggerTrackCount changing task count to ' + ld.Task_Count__c + ' lead: ' + ld.id);
            leadsToUpdate.add(ld);
        }
    }

    if(leadsToUpdate.size()>0) update leadsToUpdate;

}