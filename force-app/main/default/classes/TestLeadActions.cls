@istest
public with sharing class TestLeadActions {
    
    @istest
    public static void TestInsertSingleLead() {
        Test.startTest();
        InsertLeads(1, 'Open - Not Contacted');
        Test.stopTest();
    }

    @istest static void TestInsertBulkLead()
    {
        Long startTime = DateTime.now().getTime();
        Long startCPU = Limits.getCpuTime();
        Test.startTest();
        InsertLeads(200, 'Open - Not Contacted');
        Test.stopTest();
        system.debug('Elapsed: ' + (Datetime.Now().getTime()- startTime));
        system.debug('Elapsed CPU: ' + (Limits.getCpuTime() - startCPU));
    }


    public static void InsertLeads(Integer count, String leadstatus)
    {
        List<Lead> leadsToInsert = new List<Lead>();
        for(Integer x = 0; x<count; x++)
        {
            String xs = string.valueOf(x);
            leadsToInsert.add(new Lead(FirstName = 'f'+ xs, LastName = 'l' + xs,
                                        status = leadstatus,
                                        Company = 'c' + xs,
                                        email = 'e' + xs + '@pluralsight.com',
                                        Bypass_Declarative__c = 1));
        }
        insert leadsToInsert;
    }

    public static void UpdateLeadsStatus()
    {
        List<Lead> leads = [Select ID, Status from Lead];
        for(Lead ld: leads)
            ld.status = 'Working - Contacted';
        Test.startTest();
        update leads;
    }



}
