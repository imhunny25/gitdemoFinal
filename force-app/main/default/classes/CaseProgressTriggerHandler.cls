public class CaseProgressTriggerHandler {
    public static void updateLastcomplete(Map<Id, Case_Progress__c> newCaseProgressmap, Map<Id,Case_Progress__c> oldCaseProgressMap)
    {
        Map<Id, Case> caseMap = new Map<Id, Case>();
        Set<Id>caseProgressId = new Set<Id>();
         for(Case_Progress__c cp :newCaseProgressmap.values())
        {
            caseProgressId.add(cp.Case__c);
        }
      List< Case_Progress__c> caseProgressObj = [SELECT Id, Name, Status__c,case__c FROM Case_Progress__c 
                                            WHERE Status__c ='Completed' AND Id NOT IN : newCaseProgressmap.keyset() AND case__c IN :caseProgressId Order by Id desc];
        for(Case_Progress__c caseprogress : newCaseProgressmap.values() )
        {
            if(caseprogress.Status__c == 'Completed')
            {
                caseMap.put(caseprogress.Case__c, new case(	Id =caseprogress.Case__c, Last_Completed__c=caseprogress.Name));
            }
        }
       
        if(!caseMap.isEmpty())
        {
            update caseMap.values();
        }
       
    }

}