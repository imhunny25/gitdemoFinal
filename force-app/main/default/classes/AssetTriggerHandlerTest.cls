@isTest
public class AssetTriggerHandlerTest {
   @isTest
    public static void test_assetOppAcc()
    {
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i<1; i++)
        {
            Account acc = new Account();
            acc.Name = 'Account Assignment 12';
            acc.Phone = '123123123';
            accountList.add(acc);
        }
        insert accountList;
        List<Account> accountList2 = new List<Account>([SELECT ID, Name FROM Account]);
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0; i<2; i++)
        {
            Opportunity opp = new Opportunity();
            opp.Name = 'Opportunity Assignment 12';
            opp.StageName = 'Closed Won';
            opp.AccountId = accountList2[0].Id;
            opp.CloseDate = System.today();
            oppList.add(opp);
        }
        insert oppList;
        
        List<Asset> assList = new List<Asset>();
        for(Integer i=0; i<1; i++)
        {
            Asset assetRef = new Asset();
            assetRef.AccountId = accountList2[0].Id;
            assetRef.Name = 'Asset Assignment 12';
            assetRef.IsCompetitorProduct = true;
            assList.add(assetRef);
        }
        insert assList;
        
        List<Asset> updateAssetList = new List<Asset>([SELECT Id, Name FROM Asset]);
        System.debug('::::updateAssetList'+ updateAssetList);
        System.assertEquals(3,updateAssetList.size() );
    }
}