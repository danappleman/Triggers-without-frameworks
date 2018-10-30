public with sharing class taskTrackCount {
    
    public static void handleTrigger(TriggerOperation operationType, List<Task> newList, list<Task> oldList, simpleLeadUpdater leadUpdater)
    {
        Set<ID> leadIds = new Set<ID>();

        if( operationType == TriggerOperation.AFTER_UPDATE || 
            operationType == TriggerOperation.AFTER_INSERT)
        {
            for(Task t: newList)
            {
                if(t.whoId!=null && t.whoID.getSObjectType()==Schema.Lead.SObjectType) leadIds.add(t.whoId);
            }
        }
        if( operationType == TriggerOperation.AFTER_UPDATE || 
            operationType == TriggerOperation.AFTER_DELETE)
        {
            for(Task t: oldList)
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

        for(Lead ld: leads)
        {
            if(ld.Task_Count__c != taskCounts.get(ld.Id))
            {
                Lead toUpdate = leadUpdater.getLead(ld.id);
                toUpdate.Task_Count__c = taskCounts.get(ld.id);
                system.debug('taskTriggerTrackCount changing task count to ' + toUpdate.Task_Count__c + ' lead: ' + ld.id);
            }
        }

    }

}
