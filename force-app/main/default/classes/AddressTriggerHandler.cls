public class AddressTriggerHandler {
    public static void addressCount(List<Address__c> addressList)
    {	
        Set <Id> contactId = new Set<Id>();
        for(Address__c ads : addressList)
        {
            contactId.add(ads.contact__c);
        }
        Map<Id, Contact> contactMap = new Map<Id, Contact>([SELECT ID, Name, TotalActiveAddress__c, Recent_Active_Address__c FROM Contact WHERE ID IN :contactId]);
        String activestatus;
        for(Address__c addres : addressList)
        {	
            if(contactMap.containsKey(addres.contact__c) && addres.isActive__c == true)
            {
                Contact con = contactMap.get(addres.contact__c);
                con.TotalActiveAddress__c=con.TotalActiveAddress__c + 1;
                con.Recent_Active_Address__c=addres.Name;
            }
        }
        update contactMap.values();
    }  
}