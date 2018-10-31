public interface ITriggerExtension {
    void HandleTrigger(TriggerOperation operationType,
                        List<SObject> newList, List<SObject> oldList,
                        Map<ID, SObject> newMap, Map<ID, SObject> oldMap ) ;
}
