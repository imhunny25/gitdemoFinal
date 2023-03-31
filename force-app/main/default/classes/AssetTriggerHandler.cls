public class AssetTriggerHandler {
    //Assignment :- 12
    public static void assetOppAcc(List<Asset> assetList)
    {	
        
        Set<Id> accId = new Set<Id>();
        for(Asset ass : assetList)
        {
            if(ass.IsCompetitorProduct){
                accId.add(ass.AccountId);   
            }
        }
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, StageName, AccountId, Name FROM Opportunity 
                                                           WHERE StageName = 'Closed Won' AND AccountId In :accId]);
        List<Asset> assList = new List<Asset>();
        for(Opportunity opp : oppList)
        {
            Asset ass = new Asset();
            ass.Name = 'New Asset '+opp.Name;
            ass.AccountId = opp.AccountId;
            ass.IsCompetitorProduct = false;
            assList.add(ass);
        }
        insert assList;
    }
    
    //Assignment 13
    public static void totalOpportunityOfAsset(List<Asset> assetList){
        Set<Id>accIds=new Set<Id>();
        
        for(Asset ass : assetList)
        {
            if(ass.IsCompetitorProduct == true){
                accIds.add(ass.AccountId);  
                
            }
        }
        List<Opportunity> oppList = new List<Opportunity>([SELECT Id, StageName, AccountId, Name FROM Opportunity 
                                                           where AccountId In :accIds]);  
        
        Map<Id, List<Opportunity>> mapOfOpp =  new Map<Id,List<Opportunity>>();
        
        for(Opportunity opp:oppList)
        {
            if(!mapOfOpp.containskey(opp.accountId)){
                mapOfOpp.put(opp.accountId, new List<Opportunity> ());
            }
            mapOfOpp.get(opp.accountId).add(opp);
        }
        
        for(Asset as1 : assetList )
        {
            if(mapOfOpp.containsKey(as1.AccountId))
            {
                as1.total_Opportunity__c = mapOfOpp.get(as1.AccountId).size();
            }
        }
    }
}