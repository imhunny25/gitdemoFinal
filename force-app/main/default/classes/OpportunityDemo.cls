public class OpportunityDemo {
  public static void oppDescriptionUpdate()
  {
      List<Opportunity> oppList=new List<Opportunity>();
      oppList=[SELECT Id, Name, CloseDate, StageName, Description FROM Opportunity];
      
      if(!oppList.isEmpty())
      {
          for(Opportunity opp: oppList)
          {
              if(opp.StageName == 'Closed Won')
              {
                  opp.Description = 'Opportunity  is Closed Won';
              }else if(opp.StageName == 'Closed Lost')
             		 {
                 	 opp.Description = 'Opportunity is Closed Lost';
              		 }
          }
          if(!oppList.isEmpty())
          {
              update oppList;
          }
      }
  }
}