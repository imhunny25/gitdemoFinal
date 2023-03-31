public class AccountNameUpdate implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT Id, Name, OwnerId FROM Account WHERE Name LIKE '%Test%']);
    }
    
    public void execute(DataBase.BatchableContext  bc, List<Account> accountList)
    {
        List<Account> accList = new List<Account>();
        for(Account acc : accountList)
        {
            if(acc.name == 'Test')
            {
                acc.name = 'Testing Account';
                accList.add(acc);
            }
        }
        update accList;
    }
    
    public void finish(Database.BatchableContext bc)
    {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                            JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email
                            FROM AsyncApexJob
                            WHERE Id = :bc.getJobId()];
        if(job != null){
            List <Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>();
            String[] to = new String[] {job.CreatedBy.Email};    
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(to);
            email.setSubject('Record Name has been updated ....!');            
            email.setHtmlBody('Hello, <br/><br/>This is the test mail that you generated for Testing Account Name <br/>');
            emailList.add(email);
            try{
                Messaging.sendEmail(emailList);
            }catch(exception e){
                apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
            }   
        }
    }
}