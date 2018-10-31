public with sharing class dynamicTaskTriggerHandler implements ITriggerExtension {

    public void HandleTrigger(TriggerOperation operationType,
                        List<SObject> newList, List<SObject> oldList,
                        Map<ID, SObject> newMap, Map<ID, SObject> oldMap ) 
    {
        system.debug('Trigger extension was called');
    }

}
