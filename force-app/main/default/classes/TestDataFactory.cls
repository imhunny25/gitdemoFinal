@isTest
public class TestDataFactory {
		public static List<Account> createAccountsWithOpps(Integer numAccount, Integer NumOppPerAccount)
        {
            List<Account> accts=new List<Account>();
            for(Integer i=0; i<numAccount; i++){
                Account a=new Account(Name=' TestAccount'+i);
                 accts.add(a);
                }
            insert accts;
            
            List<Opportunity> opps=new List<Opportunity>();
            for(Integer j=0; j<numAccount; j++)
            {
                Account acct=accts[j];
                
                for(Integer k=0; k < NumOppPerAccount; k++)
                {
                    opps.add(new Opportunity( Name=acct.name +' Opportunity'+k, StageName='Prospecting',
                                             CloseDate=System.today().addMonths(1),AccountId=acct.Id));
                }       
            }
           insert opps;
            return accts;
        }
    
    
    
}