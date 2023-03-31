trigger OpportunityTrigger on Opportunity (after update, after insert, before insert, before update) {
    if(Trigger.isInsert)
    {
        if(Trigger.IsBefore)
            {
            //OpportunityTriggerHandler.oppAsset(Trigger.new);
            //OpportunityTriggerHandler.defaultProductAssociate(Trigger.New);
        
            }
        if(Trigger.IsAfter)
        {
          //  OpportunityTriggerHandler.defaultProductAssociate(Trigger.New);
          //    OpportunityTriggerHandler.opportunityProductDeduct(Trigger.new);
          // OpportunityTriggerHandler.oppAndOrder(Trigger.new);  
            
        }
    }
    if(Trigger.isUpdate)
    {
        if(Trigger.isAfter)
        {
            //OpportunityTriggerHandler.oppTest(Trigger.New, Trigger.oldMap);
            // OpportunityTriggerHandler.oppAsset(Trigger.new);
            //OpportunityTriggerHandler.defaultProductAssociate(Trigger.New);
           //  OpportunityTriggerHandler.opportunityProductDeduct(Trigger.new);
           // OpportunityTriggerHandler.oppAndOrder(Trigger.new);  
        }
    }
}