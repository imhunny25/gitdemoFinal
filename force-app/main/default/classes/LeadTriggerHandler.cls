public class LeadTriggerHandler {
    public static void customConvertStatus(List<Lead> leadList)
    {	
        List<Account> newCreateAccount = new List<Account>();
        List<Contact> newCreateConatct = new List<Contact>();
        for(Lead l :leadList)
        {
            if(l.Status == 'Custom Convert')
            {
                Account accountNew = new Account();
                accountNew.Name = l.Company;
                accountNew.Opportunity__c = l.Opportunity__c;
                accountNew.Opportunity_Names__c = l.Opportunity_Names__c;
                accountNew.Opportunity_Default_Stage__c = l.Opportunity_Default_Stage__c;
                accountNew.Opportunities_Closed_Date__c = l.Opportunities_Closed_Date__c;
                newCreateAccount.add(accountNew);
                Contact contactNew = new Contact();
                contactNew.LastName=l.LastName;
                System.debug('>>>>:::::contactNew.LastName'+contactNew.LastName);
                newCreateConatct.add(contactNew);
            }
        }
        insert newCreateAccount;
        insert newCreateConatct;
        List<Opportunity>oppList = new List<Opportunity>();
        List<Account> accList = new List <Account>([SELECT ID, Name, Opportunity__c, Opportunity_Names__c, Opportunities_Closed_Date__c, Opportunity_Default_Stage__c FROM Account Where ID IN :newCreateAccount]);
        for(Account acc : accList)
        {
            Opportunity opp = new Opportunity();
            if(acc.Opportunity__c == true)
            {
                opp.Name = acc.Opportunity_Names__c;
                opp.CloseDate = acc.Opportunities_Closed_Date__c;
                opp.StageName = acc.Opportunity_Default_Stage__c;
                opp.AccountId = acc.Id;
                oppList.add(opp);  
            }
        }
        insert oppList;
    }
}