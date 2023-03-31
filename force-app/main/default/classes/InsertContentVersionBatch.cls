public class InsertContentVersionBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        List<Account> accList=new List<Account>();
        Set<String> nameSet = new Set<String>();
        for(Integer i=0; i<5; i++)
        {
            Account acc = new Account();
            acc.Name = 'Test Content Version'+i;
            acc.Phone ='123456789'+i;
            nameSet.add(acc.Name);
            accList.add(acc);
        }
        insert accList;
        
        //List<Account> accList2 =[SELECT ID, Name From Account Where Name In : nameSet];
        String query='Select Id, Name From Account where Id In : accList';
        System.debug('query>>>' + query);
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Account> acc){
        Integer incrementVal=0;
        Map<Id,List<ContentVersion>>contentAccount = new Map<Id, List<ContentVersion>>();
        List<ContentDocumentLink> conlink = new List<ContentDocumentLink>();
        List<ContentVersion> conver = new List<ContentVersion>(); 
        for(integer i=0;i<25;i++){
            ContentVersion cv = new ContentVersion();
            cv.VersionData = Blob.valueOf('Pika');
            cv.Title = 'Filename'+i;
            cv.PathOnClient = 'myfile.pdf';
            conver.add(cv);
        }
        insert conver;
        
        Set<Id> ids = new Set<id>();
        For(ContentVersion con:conver){
            ids.add(con.id);    
        }
        List<ContentVersion> cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :ids ];
        for(Account accountRef : acc)
        {
            List<ContentVersion> mapValue = new List<ContentVersion>();
            for(Integer i=0; i<5; i++)
            {
                if(contentAccount.containsKey(accountRef.Id)){
                    mapValue = contentAccount.get(accountRef.Id);
                }
                System.debug('incrementVal>>>>>'+incrementVal);
                System.debug('cv[incrementVal]>>>>before'+cv[incrementVal]);
                mapValue.add(cv[incrementVal]);
                contentAccount.put(accountRef.Id, mapValue);   
                incrementVal++;
                System.debug('incrementVal>>>>> after'+incrementVal);
               // System.debug('cv[incrementVal]>>>>after'+cv[incrementVal]);
            }
        }
        
        System.debug('contentAccount>>>>'+contentAccount);
        /* for(sobject acc:scope){          	
For(integer i=0;i<5;i++){  
ContentDocumentLink cdl = new ContentDocumentLink();           
cdl.ContentDocumentId = cv[i].ContentDocumentId;
cdl.ShareType = 'I';
cdl.Visibility = 'AllUsers';
cdl.LinkedEntityId = acc.id; //Magic happens here
conlink.add(cdl); 
} 
}*/
        
        for(Account ant : acc)
        {
            for(ContentVersion cvId : contentAccount.get(ant.Id))
            {
                ContentDocumentLink cdl = new ContentDocumentLink();           
                cdl.ContentDocumentId = cvId.ContentDocumentId;
                cdl.ShareType = 'I';
                cdl.Visibility = 'AllUsers';
                cdl.LinkedEntityId = ant.Id; //Magic happens here
                System.debug('cdl.LinkedEntityId>>>>>'+cdl.LinkedEntityId);
                System.debug('cdl>>>>>>'+cdl);
                conlink.add(cdl);
            }
        }
        
        insert conlink;
        System.debug('<<<conlink>>>>'+conlink);
    }
    
    public void finish(Database.BatchableContext BC){
    }
    
}