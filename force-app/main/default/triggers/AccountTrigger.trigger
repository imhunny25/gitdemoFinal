trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
        	//AccountTriggerHandler.changeSendMailOldOwner( Trigger.Old, Trigger.NewMap);
        	//AccountTriggerHandler.notUpdatePrestProduct(Trigger.new, Trigger.OldMap);
        	 //AccountTriggerHandler.accountOpportunity(Trigger.new);
        	 AccountTriggerHandler.totalOppAmountAssignment(Trigger.new);
             
        }
        if(Trigger.isAfter)
        {
            //AccountTriggerHandler.contactIformation(Trigger.new, Trigger.OldMap);
           // AccountTriggerHandler.notUpdatePrestProduct(Trigger.new, Trigger.Old);
           //AccountTriggerHandler.accountOpportunity(Trigger.new);
           // AccountTriggerHandler.totalOppAmountAssignment(Trigger.new);
           
        }
    }  
    
    if(Trigger.isInsert)
    {
        if(Trigger.isBefore){
            //AccountTriggerHandler.demoBatchApex();
            //AccountTriggerHandler.billingAdressPopulate(Trigger.New);
           
            
        }
        if(Trigger.isAfter)
        {
          //AccountTriggerHandler.contactIformation(Trigger.new, null);
        }
    }
}