public with sharing class TriggerExtensionSupport {
    
    public static List<ITriggerExtension> getTriggerClasses(String objectType) 
    {
        List<Dynamic_Trigger__mdt> triggerSettings = 
            [Select Class_Name__c from Dynamic_Trigger__mdt 
            where Object_Type__c = :objectType
            Order By Priority__c Asc];
        List<ITriggerExtension> results = new List<ITriggerExtension>();

        for(Dynamic_Trigger__mdt setting: triggerSettings)
        {
            System.Type thetype = Type.forName(setting.Class_Name__c);
			if(thetype==null) thetype = Type.forName('',setting.Class_Name__c);	// Try resolving local class
			if(thetype!=null) 
            {
    			Object theobject = thetype.newInstance();
			    if(theobject instanceof ITriggerExtension) results.add((ITriggerExtension)theobject);
            }

        }
        return results;
    }
}
