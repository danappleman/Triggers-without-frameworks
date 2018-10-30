public with sharing class simpleLeadUpdater {

    Map<ID, Lead> leadsToUpdate = new Map<Id, Lead>();

    public Lead getLead(ID leadID)
    {
        Lead targetLead = leadsToUpdate.get(leadID);
        if(targetLead == null) 
        {
            targetLead = new Lead(ID = leadID);
            leadsToUpdate.put(leadID, targetLead);
        }
        return targetLead;
    }

    public void updateLeads()
    {
        if(leadsToUpdate.size()>0) update leadsToUpdate.values();
    }

}
