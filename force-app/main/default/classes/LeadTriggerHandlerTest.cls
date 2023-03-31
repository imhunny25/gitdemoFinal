@isTest
private class LeadTriggerHandlerTest {
    @isTest
    public static void test_customConvertStatus()
    {
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0; i<20; i++)
        {
            Lead li = new Lead();
            li.FirstName='Test';
            li.LastName='Sample '+i;
            li.Company=' Sample Test.co'+i;
            li.Status='Custom Convert';
            li.Opportunity__c=true;
            li.Opportunity_Default_Stage__c='Custom Convert';
            li.Opportunity_Names__c='Test Purpose Opportunity';
            li.Opportunities_Closed_Date__c=System.today();
            leadList.add(li);
        }
        insert leadList;
        List<Account> accList = new List <Account>([SELECT ID, Name FROM Account WHERE Name LIKE '%Sample Test.co%']);
        List<Opportunity> opi= new List <Opportunity>([ SELECT ID, Name FROM Opportunity]);    
        System.assertEquals(20, accList.size());
        System.assertEquals(20, opi.size());
    }
}