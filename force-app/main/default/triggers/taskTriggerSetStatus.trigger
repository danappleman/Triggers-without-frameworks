trigger taskTriggerSetStatus on Task (after insert) {

    // When a task referencing a lead is created, look at it's status. 
    // If 'Open - Not Contacted', set it to 'Working - Contacted'
    // If 'Working - Contacted', set it to 'Working - Harder'

    Set<ID> leadIds = new Set<ID>();

    for(Task t: trigger.new)
    {
        if(t.whoId!=null && t.whoID.getSObjectType()==Schema.Lead.SObjectType) leadIds.add(t.whoId);
    }

    List<Lead> leads = [Select ID, Status from Lead where ID in :leadIds];
    List<Lead> leadsToUpdate = new List<Lead>();
    for(Lead ld: leads)
    {
        system.debug('taskTriggerSetStatus current lead status: ' + ld.status + ' lead: ' + lead.id);

        switch on ld.status
        {
            when 'Open - Not Contacted'
            {
                ld.status = 'Working - Contacted';
                system.debug('taskTriggerSetStatus setting lead status to ' + ld.status + ' lead: ' + lead.id);
                leadsToUpdate.add(ld);
            }
                
            when 'Working - Contacted' {
                ld.status = 'Working Harder';
                system.debug('taskTriggerSetStatus setting lead status to ' + ld.status + ' lead: ' + lead.id);
                leadsToUpdate.add(ld);
            }
        }
    }
    if(leadsToUpdate.size()>0) update leadsToUpdate;

}