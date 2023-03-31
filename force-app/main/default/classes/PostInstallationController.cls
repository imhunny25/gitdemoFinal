public class PostInstallationController {
    /*  @AuraEnabled
public static Evisort_Workspace_Settings__c postInstallation(String domain, String subdomain, String workspace){
try {
Evisort_Workspace_Settings__c settings = Evisort_Workspace_Settings__c.getOrgDefaults();
if(String.isNotBlank(domain) && String.isNotBlank(subdomain) && String.isNotBlank(workspace)){
settings.Domain__c = domain;
settings.subdomain__c=subdomain;
settings.Workspace__c = workspace;
upsert settings;
return settings; 
}else{
return settings;
}
} catch (Exception e) {
throw new AuraHandledException(e.getMessage());
}  
}

@AuraEnabled
public static Boolean getNameCridencial(){
try {
List<NamedCredential> namecridentialref =[SELECT Id, DeveloperName FROM NamedCredential where DeveloperName='Evisort'];
if(namecridentialref.size() >1)
{
return true;
}
return false;

} catch (Exception e) {
throw new AuraHandledException(e.getMessage());
}
}  */
    
    @AuraEnabled
    public static void saveScheduler(String monthWeekDetials)
    {
        Map<String, Object> demoMap = (Map<String, Object>)JSON.deserializeUntyped(monthWeekDetials);
        System.debug('demoMap::>>>'+demoMap);
        
        if(demoMap.containsKey('weekly'))
        {
            System.debug('demoMap::>>weekly>'+demoMap.get('weekly'));
            Map<String, Object> m = (Map<String, Object>) demoMap.get('weekly');
            System.debug('m>>>>>>'+m);
            System.debug('weekDay>>>>>'+ m.get('weekDay'));
            Map<String, String>weekDayMap = new Map<String, String>();
            for(String wd : m.keySet())
            {
                System.debug('w>>>>>'+wd);
            }
        }else if(demoMap.containsKey('monthly'))
        {
            System.debug('demoMap::>>monthly>'+demoMap.get('monthly'));
            Map<String, Object> m = (Map<String, Object>) demoMap.get('monthly');
            System.debug('monthly>>>>>>'+m);
            System.debug('start date>>>>>'+ m.get('startDate'));
        }
        
    }
    
}