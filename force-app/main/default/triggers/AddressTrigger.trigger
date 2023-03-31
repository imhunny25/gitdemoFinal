trigger AddressTrigger on Address__c (before insert) {
    if(Trigger.isInsert)
    {
        if(Trigger.isBefore)
        {
            AddressTriggerHandler.addressCount(Trigger.New);
        }
    }

}