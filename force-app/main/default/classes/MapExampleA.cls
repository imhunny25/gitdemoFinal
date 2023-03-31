public class MapExampleA {
    public static  void mapexample(){
        Map<Id, Contact> contMap = new Map<Id, Contact>([SELECT Id, Name, AccountId FROM Contact]);
        System.debug('>>>contMap'+ contMap);
        
        List<Contact> accList = new List<Contact>([SELECT ID, Name, AccountId FROM Contact ]);
        Map<Id, Contact> contactmap = new Map<Id, Contact>(accList);
        System.debug('contactmap:::::'+ contactmap);
        
        
        List<String>NameList= new List<String>();
        Set<Id>accountId = new Set<Id>();
        for(Contact con : accList)
        {
           if(contactmap.containsKey(con.Id))
           {
               NameList.add(contactmap.get(con.Id).Name);
               accountId.add(contactmap.get(con.id).AccountId);
           }
        }
        System.debug('>>NameList'+NameList);
        System.debug('>>accountid'+accountId );
        
        
        List<String>AccountHolderName= new List<String>();
        for(Account acc : [SELECT Id, Name FROM Account WHERE ID In : accountId])
        {
            AccountHolderName.add(acc.Name);
        }        
        System.debug('::>>AccountHolderName '+ AccountHolderName);
        
        
        Map<Id, Account> accountMap= new Map<Id, Account>();
        for(Contact con :accList){
        		if(! accountMap.containsKey(con.accountId))
       			 {
            			accountMap.put(con.AccountId, null);
       			 }else{
            			//System.debug(con.accountId);
       				   }
        	}
       			
        System.debug('<<<<<<accountMap'+accountMap);     
    }
}