trigger AssetTrigger on Asset (after insert, after update, before update) {
    
    if(Trigger.isbefore){
         if(Trigger.isInsert)
         {}
        else if(Trigger.isUpdate){
             AssetTriggerHandler.totalOpportunityOfAsset(Trigger.new); 
            
        }
        
    }else if(Trigger.isAfter){
        if(Trigger.isInsert)
         {
             AssetTriggerHandler.assetOppAcc(Trigger.new); 
         }
        else if(Trigger.isUpdate){
             AssetTriggerHandler.assetOppAcc(Trigger.new);
        }
    }   
}