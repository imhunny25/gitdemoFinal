public class DueDatesendMail implements Schedulable {
    public void execute(SchedulableContext ctx) 
    {	
        Set<Id>contIdSet = new Set<Id>();
        List<Fee__c> feeList = new List<Fee__c>();
        feeList = [SELECT ID, Due_Date__c, ContactId__c FROM Fee__C];
        for(Fee__c f : feeList)
        {
           contIdSet.add(f.ContactId__c);
        }
        Map<Id, Contact> contactMap = new Map<Id, Contact>([SELECT Id, Name, Email FROM Contact WHERE Id In :contIdSet]);
        for(Fee__c fe : feeList){
            Integer reminderDate = System.today().daysBetween(fe.Due_Date__c);
            if(reminderDate == 7 || reminderDate == 3 || reminderDate == 1)
            {
               List <Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>();

                Contact con = contactMap.get(fe.ContactId__c);
                String[] to = new String[] {con.Email};    
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(to);
                email.setSubject('Due Date!');            
                email.setHtmlBody('Hello, <br/><br/>This is the test mail that you generated for Due Date <br/>');
                emailList.add(email);
            try{
                Messaging.sendEmail(emailList);
            }catch(exception e){
                apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
            }   
            }else{
                System.debug('>>>><<<<< test else part'); 
            }
        }
    }
    }