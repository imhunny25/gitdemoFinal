public class OpportunityTriggerHandler {
  /*  public static void oppTest(List<Opportunity> oppList, Map<Id, Opportunity> oppOldMap)
    {	
        Map<Id, Opportunity> oppMap= new Map<Id, Opportunity>([SELECT ID, Name, AccountId, StageName FROM Opportunity 
                                                               WHERE Id IN :oppList]);
        List<String> stageNameList = new List<String>();
        stageNameList.add('Closed Won');
        stageNameList.add('Got Payment');
        stageNameList.add('Got Partial Payment');
        Set<Id> accountIds= new Set<Id>();
        for(Opportunity op : oppList)
        {
            accountIds.add(op.AccountId);
        }
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT ID, Name,Won_Opportunities__c, Present_prods__c FROM Account 
                                                            WHERE ID IN :accountIds]);
        List<OpportunityLineItem> oppLineItemList = [SELECT Id, Product2.Id, OpportunityId, Quantity FROM OpportunityLineItem 
                                                     Where OpportunityId In :oppList];
        List<Product2> productList = [SELECT Id, Name FROM Product2 WHERE NAME = 'Test Product'];
        
        Map<Id, Integer> productmap = new Map<Id, Integer>();
        
        for(OpportunityLineItem oppli : oppLineItemList)
        {	
            Opportunity opp = oppMap.get(oppli.OpportunityId);
            Account acc = accountMap.get(opp.AccountId);
            Opportunity oppOld = oppOldMap.get(oppli.OpportunityId);
            
            if(productmap.containsKey(opp.Id))
            {
                Integer j = productmap.get(opp.Id);
                productmap.put(opp.Id, j + 1);
            }else
            {
                productmap.put(opp.Id, 1);
            }
            
            if(oppli.Product2Id == productList[0].Id)
            {
                //Sceniro - 1
                if(stageNameList.contains(oppOld.StageName) && stageNameList.contains(opp.StageName))
                {
                    break;
                }else{
                    if( opp.StageName == 'Closed Won' )
                    {	
                        acc.Won_Opportunities__c = acc.Won_Opportunities__c + 1; 
                        acc.Present_prods__c = productmap.get(opp.Id) + 1; 
                        
                    } else if(opp.StageName != 'Closed Won')
                    {	
                        acc.Won_Opportunities__c = acc.Won_Opportunities__c - 1; 
                        acc.Present_prods__c = productmap.get(opp.Id) - 1;     
                    }
                }
            }
        }
        update accountMap.values();
    }  */
    
    // Assignment :- 13
    /*   Public static void oppAsset(List<Opportunity> oppList)
{
Set<Id> oppSet = new Set<Id>();
for(Opportunity opp : oppList)
{	
if(opp.StageName == 'Closed Won')
{
oppSet.add(opp.Id);
}
}

Map<Id, OpportunityLineItem> opliMap = new Map<Id, OpportunityLineItem>([SELECT Id, Name, Product2.Name, Opportunity.AccountId FROM OpportunityLineItem 
WHERE OpportunityId In :oppSet]);
List<Asset> assList = new List<Asset>();
for(OpportunityLineItem opli : opliMap.values() )
{
Asset ass = new Asset();
ass.Name = opli.Product2.Name;
ass.AccountId = opli.Opportunity.AccountId;
assList.add(ass);

}
insert assList;
}   */
    
    /*
public static void defaultProductAssociate(List<Opportunity> oppList)
{
List<OpportunityLineItem> opliList = new List<OpportunityLineItem>();
List<PriceBookEntry> priceBookList = [SELECT Id, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry WHERE 
PriceBook2.isStandard=true LIMIT 1];
for(Opportunity opp : oppList)
{
OpportunityLineItem opli = new OpportunityLineItem();
opli.OpportunityId = opp.Id;
opli.PricebookEntryId = priceBookList[0].Id;
opli.Quantity = 10.2;
opli.TotalPrice = 2000;
opliList.add(opli);
}
insert opliList;
}  */
    
    /* public static void opportunityProductDeduct(List <Opportunity> oppList)
{
Set<Id> oppIdSet = new Set<Id>();
for(Opportunity opp : oppList)
{
oppIdSet.add(opp.Id);
}

List<opportunityLineItem> opliList = [SELECT Id, Quantity, product2id FROM OpportunityLineItem 
WHERE OpportunityId In :oppIdSet];

Set<Id> prodId = new Set<Id>();
for(opportunityLineItem op : opliList)
{
prodId.add(op.Product2Id);
}
Map<Id, Product2> prodMap = new Map<Id, Product2>([SELECT Id, Total_Quantity__c, Available_Quantity__c FROM Product2
WHERE ID In :prodId]);
for(OpportunityLineItem opli : opliList)
{
Product2 pro = prodMap.get(opli.Product2Id);
pro.Available_Quantity__c = pro.Total_Quantity__c - opli.Quantity;
}
update prodMap.values();   

} */
    
    
    public static void oppAndOrder(List<Opportunity>oppList)
    {
        Set<Id> oppSet = new Set<Id>();
        for(Opportunity opp : oppList)
        {
            if(opp.Get_Order_Line_Items__c = true)
            {
                oppset.add(opp.Id);
            }
        }
        
        List<Order> orderList = new List<Order>([SELECT Id, Name, OpportunityId FROM Order 
                                                 WHERE OpportunityId In :oppSet]);
        Set<Id> orderIdSet = new Set<Id>();
        Integer counter =0;
        for(Order op : orderList)
        {
            orderIdSet.add(op.Id);
            counter ++;
        }
       
        //if(counter > 2 )
        //{
          Map<Id, OrderItem> orderItemMap = new Map<Id, OrderItem>([SELECT Id, AvailableQuantity, OrderId, Product2Id 
                                                                  FROM OrderItem WHERE OrderId IN :orderIdSet]);  
        //}
        
        List<opportunityLineItem> opliList = new List<opportunityLineItem>([SELECT Id, OpportunityId FROM OpportunityLineItem
                                                                            WHERE OpportunityId In :oppSet]);
        for(opportunityLineItem opliObj : opliList)
        {	
          //OrderItem orderItemObject = new OrderItem();
            OrderItem orderItemObj = orderItemMap.get(opliObj.Id);
            OpportunityLineItem opli = new OpportunityLineItem();
            opli.OpportunityId = opliObj.Id;
            
            
        }
        
        
        /*    
List<OrderItem> orderItemList = new List<OrderItem>([SELECT Id, AvailableQuantity, 	OrderId, Product2Id 
FROM OrderItem WHERE OrderId IN :orderIdSet]);
Set<Id>productIdSet = new Set<Id>();
for(OrderItem orderItemObj : orderItemList)
{
productIdSet.add(orderItemObj.Product2Id);
}

Map<Id, Product2> productMap = new Map<Id, Product2>([SELECT Id, Name FROM Product2 WHERE Id In :productIdSet]);	*/
        
        
    }
    
}