trigger leadTrigger on Lead (after insert, after update) {
    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {
            LeadTriggerHandler.customConvertStatus(Trigger.new);  
        }
    }
    if(Trigger.isUpdate)
    {
        if(Trigger.isAfter)
        {
            LeadTriggerHandler.customConvertStatus(Trigger.new);  
        }
    }
}