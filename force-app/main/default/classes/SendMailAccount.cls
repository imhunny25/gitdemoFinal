public class SendMailAccount implements Schedulable {
    public void execute(SchedulableContext ctx) 
    {
        List<Account> accountList = new List<Account>([SELECT Id, Name, OwnerId FROM Account WHERE Name='Test User']);
        Set<Id> ownerSet = new Set<Id>();
        for(Account acc : accountList)
        {
            ownerSet.add(acc.OwnerId);
        }
        Map<Id, User> userMap = new Map<Id, User>([SELECT Id, Email FROM User WHERE Id In :ownerSet]);
        List <Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>();
        if(userMap.size() > 0){
            for( Account acc : accountList)
            {
                User u = userMap.get(acc.OwnerId);
                String[] to = new String[] {u.Email};    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(to);
                email.setSubject('Account Test User!');            
                email.setHtmlBody('Hello, <br/><br/>This is the test mail that you generated for Account Test User. <br/>');
                emailList.add(email);
            }
            try{
                Messaging.sendEmail(emailList);
            }catch(exception e){
                apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
            }   
        }	
    }
    
}