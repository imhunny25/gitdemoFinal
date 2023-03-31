trigger OrderTrigger on Order (before insert, after insert, before update, after update){
    if(trigger.isInsert)
    {
        if(Trigger.isBefore)
        {
            
        }
        if(trigger.isAfter)
        {
          OrderTriggerHandler.oppAndOrder(Trigger.new);  
        }
    }
    if(trigger.isUpdate)
    {
       if(Trigger.isBefore)
        {
            
        }
        if(trigger.isAfter)
        {
          OrderTriggerHandler.oppAndOrder(Trigger.new);  
        } 
    }
}