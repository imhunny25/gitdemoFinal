public class OpportunityLeadUpdate implements Database.Batchable<sObject>, Database.stateful {
    public Integer recordCount=0;
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT ID, NAME FROM Opportunity]);
    }
    
    public void execute(DataBase.BatchableContext  bc, List<Opportunity> opps)
    {
        List<Opportunity> oppList= new List<Opportunity>();
        for(Opportunity opp : opps)
        {
            opp.LeadSource = 'WEB';
            oppList.add(opp);
        }
        update oppList;
        recordCount = recordCount+opps.size();
    }
    
    public void finish( Database.BatchableContext bc)
    {
        System.debug('Total Record Count :- '+ recordCount);
    }

}