trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update , After delete) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
			//ContactTriggerHandler.autoPopulateAccountDetails(Trigger.New);
            //ContactTriggerHandler.duplicateWebsiteFlag(Trigger.New);
            //ContactTriggerHandler.mobileCanNotDuplicateContact(Trigger.New);
            //ContactTriggerHandler.contactAndAccountNameSameEmailPopulate(Trigger.New, Trigger.Old);
            //ContactTriggerHandler.sameRatingNameOfAccountContact(Trigger.New);
            //ContactTriggerHandler.relateorphinecontact(Trigger.New);
            
            
        }
        if(Trigger.isAfter){
           	//ContactTriggerHandler.salaryCal(Trigger.new, Trigger.OldMap); 
           	//ContactTriggerHandler.sameRatingNameOfAccountContact(Trigger.New);
           	 ContactTriggerHandler.relateorphinecontact(Trigger.New);
          
        }
    }
    
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            //ContactTriggerHandler.autoPopulateAccountDetails(Trigger.New); 
            //ContactTriggerHandler.duplicateWebsiteFlag(Trigger.New); 
            //ContactTriggerHandler.mobileCanNotDuplicateContact(Trigger.New);
           // ContactTriggerHandler.contactAndAccountNameSameEmailPopulate(Trigger.New, Trigger.Old);
            
        }
        if(Trigger.isAfter)
        {
           // ContactTriggerHandler.sameRatingNameOfAccountContact(Trigger.New);
        	//ContactTriggerHandler.salaryCal(Trigger.new, Trigger.OldMap);
        }
    }
    
    if(Trigger.isDelete){
        if(Trigger.isBefore)
        {
			//ContactTriggerHandler.deleteContact(Trigger.old); 
			
									
        }
        if(Trigger.isAfter)
        {
			//ContactTriggerHandler.deleteContact(Trigger.Old, Trigger.OldMap);
			//ContactTriggerHandler.deleteContact(Trigger.old); 
			
        }
    }
}