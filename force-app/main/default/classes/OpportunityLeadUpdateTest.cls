@isTest
private class OpportunityLeadUpdateTest {
    @isTest
    static void testMethodOpportunity()
    {
        Account ac =new Account( name=' test');
        insert ac;
        List<Opportunity> oppList = new List<Opportunity>();
        for(integer i=0; i<1000; i++)
        {
            Opportunity opp = new opportunity();
            opp.AccountId = ac.id;
            opp.StageName = 'Closed Won';
            opp.Name = 'Test';
            opp.CloseDate = System.today();
            oppList.add(opp);
        }
        insert oppList;
        
        Test.startTest();
            OpportunityLeadUpdate ol = new OpportunityLeadUpdate();
			Id batchId = Database.executeBatch(ol,1000);    
        	Test.stopTest();
        
        System.assertEquals(1000, [SELECT count() FROM Opportunity WHERE LeadSource ='WEB']);
    }
    
}