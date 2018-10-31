public with sharing class taskSetStatus {
    
    private static Set<ID> statusUpdated = new Set<ID>();

    public static void handleTrigger(List<Task> newTasks, simpleLeadUpdater leadUpdater) {
        // When a task referencing a lead is created, look at it's status. 
        // If 'Open - Not Contacted', set it to 'Working - Contacted'
        // If 'Working - Contacted', set it to 'Working - Harder'

        Set<ID> leadIds = new Set<ID>();

        for(Task t: newTasks)
        {
            if(t.whoId!=null && t.whoID.getSObjectType()==Schema.Lead.SObjectType && 
                !t.Declarative_Created__c) leadIds.add(t.whoId);
        }

        List<Lead> leads = [Select ID, Status from Lead where ID in :leadIds];
        for(Lead ld: leads)
        {
            if(statusUpdated.contains(ld.id)) continue; // Skip those already updated

            system.debug('taskTriggerSetStatus current lead status: ' + ld.status + ' lead: ' + lead.id);

            switch on ld.status
            {
                when 'Open - Not Contacted'
                {
                    Lead toUpdate = leadUpdater.getLead(ld.id);
                    toUpdate.status = 'Working - Contacted';
                    statusUpdated.add(ld.id);
                    system.debug('taskTriggerSetStatus setting lead status to ' + toupdate.status + ' lead: ' + lead.id);
                }
                    
                when 'Working - Contacted' {
                    Lead toUpdate = leadUpdater.getLead(ld.id);
                    toUpdate.status = 'Working Harder';
                    statusUpdated.add(ld.id);
                    system.debug('taskTriggerSetStatus setting lead status to ' + toUpdate.status + ' lead: ' + lead.id);
                }
            }
        }

    }
}
