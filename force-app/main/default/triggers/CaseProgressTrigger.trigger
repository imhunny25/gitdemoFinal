trigger CaseProgressTrigger on Case_Progress__c (before insert, before update, after insert, after update) {
    if(Trigger.isUpdate)
    {
        if(Trigger.isAfter)
        {
            CaseProgressTriggerHandler.updateLastcomplete(Trigger.newMap, Trigger.oldMap);
        }
    }

}