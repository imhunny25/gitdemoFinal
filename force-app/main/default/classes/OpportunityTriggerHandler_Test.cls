@isTest(seealldata=true)
public class OpportunityTriggerHandler_Test {
    /*   @isTest
public static void oppTest()
{
List<Account> accountList = new List<Account>();
for(Integer i=0; i<5; i++)
{
Account acc = new Account();
acc.Name = 'Test Opportunity Account' + i;
acc.Present_prods__c = 0;
acc.Won_Opportunities__c = 0;
accountList.add(acc);
}
insert accountList;
List<Account> accountFetch = [SELECT ID, Name FROM Account];

List<Opportunity> oppList = new List<Opportunity>();
for(Integer i=0; i<4; i++)
{
Opportunity opp = new Opportunity();
opp.Name = 'Test Opportunity '+i;
opp.StageName = 'Closed Won';
opp.AccountId = accountFetch[0].Id;
}
}  

*/
    
    //Assignment :- 13
  /*  @isTest
    public static void test_oppAsset()
    {	
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<10; i++)
        {
            Account acc = new Account();
            acc.Name = 'Assignment 13 Account';
            acc.Phone = '1231231231';
            accList.add(acc);
        }
        insert accList;
        List<Account> updateNewAccountList = new List<Account>([SELECT ID, Name FROM Account]);
        
        Id pricebookId = Test.getStandardPricebookId();
        
        List<Product2> prodList = new List<Product2>();
        for(Integer i=0; i<10; i++)
        {
            Product2 prod = new Product2();
            prod.Name = 'Product X Assignment 13';
            prod.ProductCode = 'Pro-X';
            prod.isActive = true;
            prodList.add(prod);
        }
        insert prodList;
        List<Product2> updateProdList = new List<Product2>([SELECT Id, Name, ProductCode FROM Product2]);
        
        List<PricebookEntry> pbEntryList = new List<PricebookEntry>();
        for(Integer i=0 ; i<1; i++)
        {
            PricebookEntry pbEntry = new PricebookEntry();
            pbEntry.Pricebook2Id = pricebookId;
            pbEntry.Product2Id = updateProdList[0].Id;
            pbEntry.UnitPrice = 1001.00;
            pbEntry.IsActive = true;
            pbEntryList.add(pbEntry);
        } 
        insert pbEntryList;
        List<PricebookEntry> updatePbe = new List<PricebookEntry>([SELECT Id, Name FROM PricebookEntry]);
        
        List<Opportunity>oppList = new List<Opportunity>();
        for(Integer i=0; i<5; i++)
        {
            Opportunity opp = new Opportunity();
            opp.AccountId = updateNewAccountList[0].Id;
            opp.Name = 'Assignment 13 Opportunity';
            opp.StageName = 'Closed Won';
            opp.CloseDate = System.today();
            oppList.add(opp);
        }
        insert oppList;
        
        List<Opportunity> updateOppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity]);
        
        
        List<OpportunityLineItem> opliList = new List<OpportunityLineItem>();
        for(Integer i = 0; i < 5; i++ ){
            OpportunityLineItem opli = new OpportunityLineItem();
            opli.OpportunityId = updateOppList[0].Id;
            opli.PricebookEntryId = updatePbe[0].Id;
            opli.Quantity = 345.00;
            opli.TotalPrice = 5000;
            opliList.add(opli);
        }
        insert opliList;
        
    }	*/
    
 /*   @isTest    
    public static void defaultProductAssociate()
    {
        List<Opportunity>oppList = new List<Opportunity>();
        for(Integer i=0; i<5; i++)
        {
            Opportunity opp = new Opportunity();
            opp.Name = 'Assignment 13 Opportunity';
            opp.StageName = 'Closed Won';
            opp.CloseDate = System.today();
            oppList.add(opp);
        }
        insert oppList;
        
        List<OpportunityLineItem> allOppList = [SELECT Id, Name, OpportunityId, Product2Id 
                                                FROM OpportunityLineItem
                                                WHERE OpportunityId IN :oppList];
        System.assertEquals(allOppList.size(), 5);
        System.assertNotEquals(allOppList[3].Product2Id, null);
    }		*/
        
  /*      @isTest
        public static void opportunityProductDeductTest()
    {	
        Id pricebookId = Test.getStandardPricebookId();
        
        List<Product2> prodList = new List<Product2>();
        for(Integer i=0; i<10; i++)
        {
            Product2 prod = new Product2();
            prod.Name = 'Product TEST '+i;
            prod.ProductCode = 'Pro-X';
            prod.isActive = true;
            prodList.add(prod);
        }
        insert prodList;
        List<Product2> updateProdList = new List<Product2>([SELECT Id, Name, ProductCode FROM Product2 
                                                            WHERE NAME = 'Product TEST 1']);
        
        PricebookEntry pbEntry = new PricebookEntry();
        pbEntry.Pricebook2Id = pricebookId;
        pbEntry.Product2Id = updateProdList[0].Id;
        pbEntry.UnitPrice = 145.00;
        pbEntry.IsActive = true;
        insert pbEntry;
       
        List<PricebookEntry> updatePbe = new List<PricebookEntry>([SELECT Id, Name FROM PricebookEntry WHERE UnitPrice =145.00]);
        
        List<Opportunity>oppList = new List<Opportunity>();
        Opportunity opp = new Opportunity();
        opp.Name = 'Assignment';
        opp.StageName = 'Closed Won';
        opp.CloseDate = System.today();
        oppList.add(opp);
        insert oppList;
        List<Opportunity> updateOppList = new List<Opportunity>([SELECT Id, Name FROM Opportunity 
                                                                 WHERE Name='Assignment']);
        List<OpportunityLineItem> opliList = new List<OpportunityLineItem>();
        for(Integer i = 0; i < 5; i++ ){
            OpportunityLineItem opli = new OpportunityLineItem();
            opli.OpportunityId = updateOppList[0].Id;
            opli.PricebookEntryId = updatePbe[0].Id;
            opli.Product2Id = updateProdList[0].Id;
            opli.Quantity = 4.00;
            opli.TotalPrice = 20;
            opliList.add(opli);
        }
        insert opliList;
        List<OpportunityLineItem> opliListUpdate = [SELECT Id, Name, Product2Id, Product2.Name, Product2.Total_Quantity__c 
                                                   FROM OpportunityLineItem
                                                   WHERE OpportunityId = :updateOppList[0].Id];
        List<Product2> updateProdList3 = new List<Product2>([SELECT Id, Name, ProductCode, Available_Quantity__c FROM Product2 
                                                            WHERE NAME = 'Product TEST 1']);
        System.assertEquals(96, updateProdList3[0].Available_Quantity__c);
    }      */
}