public class AccountTriggerHandler {
    
    //Assignment 2: send owner email
   /* public static void changeSendMailOldOwner(List <Account> acctList, Map <Id, Account> accMap)
    {				
        // getting owner id form Account  sObject
        Set<Id> UserId= new Set<Id>();
        for( Account acc: acctList)
        {
            Account newAcc = accMap.get(acc.id);
            if(acc.OwnerId != newAcc.OwnerId){
                UserId.add(acc.OwnerId);
            }
        }
        Map<id, User> userMap= new Map<Id, User>([SELECT Id, Email FROM User
                                                  WHERE Id IN :UserId]);
        List <Messaging.SingleEmailMessage> emailList= new List<Messaging.SingleEmailMessage>();
        if(userMap.size() > 0){
            for( Account acc : acctList)
            {
                User u = userMap.get(acc.OwnerId);
                String[] to = new String[] {u.Email};    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(to);
                email.setSubject('Owner Changed!');            
                email.setHtmlBody('Hello, <br/><br/>This is the test mail that you generated for owner change. <br/>');
                emailList.add(email);
            }
            try{
                Messaging.sendEmail(emailList);
            }catch(exception e){
                apexpages.addmessage(new apexpages.message(apexpages.severity.error,e.getMessage()));
            }   
        }	
    }*/
    
    /* Assignment 5 :- Whenever the field value is entered/Changed,create a New Contact with the following details and delete the older Contact.
Name will go to Contact's Name. Email to Contact Email,Phone To Contact Phone and Company to Contact's Description. */
   /* public static void contactIformation(List<Account> accoutsList, Map<Id,Account> accountoldMap)
    {	
        List <String> oldParts=new List<String>(); 
        Map<Id, String> ValuesMap = new Map<Id, String>();
        List<Contact> contactList = [Select Id, Name,AccountId, LastName FROM Contact WHERE AccountId = :accoutsList];
        System.debug('contactList::>>>'+contactList);
        List<Contact> olderContact = new List<Contact>();
        if(accountoldMap != null){ 
        for(Account accounts: accoutsList)
        {
            String textsplit;
            textsplit=accountoldMap.get(accounts.Id).Contact_Information__c;
            oldParts=textsplit.split(',');    
            List<String>separateOld=new List<String>();
            for( Integer i=0; i<oldParts.size(); i++){
                separateOld.add(oldParts[i].substringAfterLast(':').trim());
            } 
            ValuesMap.put(accounts.Id, separateOld[0]);
        }
        
        for(Contact con : contactList){
            if(ValuesMap.containsKey(con.AccountId) && con.Name.equals(ValuesMap.get(con.AccountId)))
            {
              olderContact.add(con);
            }
        }
        delete olderContact;
        }
        
        
        //insert
        List<String>parts= new List<String>();
        List<Contact> conList= new List<Contact>();
       
        for(Account acc :accoutsList)
        { 	if( acc != null){
            String text=acc.Contact_Information__c;
            parts=text.split(',');
            List<String>separate=new List<String>();
            for( Integer i=0; i<parts.size(); i++){
                separate.add(parts[i].substringAfterLast(':'));
            }
            Contact con= new Contact();
            con.LastName=separate[0];
            con.Email=separate[1];
            con.Phone=separate[2];
            con.Description=separate[3];
            con.AccountId=acc.Id;
            conList.add(con);
            }
        }
        insert conList;
    } */
    
    //Assignment :- 10
    
   /* public static void notUpdatePrestProduct(List<Account> accList, Map<Id, Account> oldAccMap)
    {	
        if(accList != null){
       		 for(Account acc : accList)
       			 {	
           			 //if(oldAccMap.get(acc.Id).Present_prods__c != 0 && oldAccMap.get(acc.Id).Won_Opportunities__c != 0){
            			acc.Present_prods__c = oldAccMap.get(acc.Id).Present_prods__c;
         				acc.Won_Opportunities__c = oldAccMap.get(acc.Id).Won_Opportunities__c;
           			 //}
       			 }   
       	 }
    }*/
    
  /*  public static void demoBatchApex(){
		AccountNameUpdate accoutRef = new AccountNameUpdate();
		Id batchId = Database.executeBatch(accoutRef);
    }  */
    
    //Write a trigger on Account , when an account insert , automatically account billing address should 
    //populate into the account shipping address.
 /*   public static void billingAdressPopulate(List<Account> accList)
    {
        if(!accList.isEmpty()){
        for(Account acc : accList)
        {
           acc.ShippingStreet = acc.BillingStreet;
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingState = acc.BillingState;
            acc.ShippingPostalCode = acc.BillingPostalCode;
            acc.ShippingCountry = acc.BillingCountry;
            acc.ShippingLatitude = acc.BillingLatitude;
            acc.ShippingLongitude = acc.BillingLongitude;
        }
            }
    }		*/
    
    
  //  3. Write a trigger on Account when Account is update check all opportunity inside the account.
  //      Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.

  /*  public static void accountOpportunity(List<Account> accList)
    {
        Set<Id> accountIdSet = new Set<Id>();
        for(Account acc : accList)
        {
            accountIdSet.add(acc.Id);
        }
        
       List<Opportunity> oppList = new List<Opportunity>([SELECT ID, StageName, createdDate, Name FROM Opportunity WHERE AccountId In :accountIdSet]);
      
        for(Opportunity opp : oppList)
        {	
         	Date oppCreatedDate = date.newinstance(opp.CreatedDate.year(), opp.CreatedDate.month(), opp.CreatedDate.day());
         	Integer days = oppCreatedDate.daysBetween(System.today());
         
         	if(opp.stageName != 'Closed Won' && days > 30)
            {
                opp.StageName = 'Closed Lost';
                System.debug('<<<<Stage'+ opp.StageName);
            }
        }
        update oppList;
    }		*/
    
    
    public static void totalOppAmountAssignment(List<Account> accList)
    {
        Set<Id> accIdSet = new Set<Id>();
        for(Account acc : accList)
        {
            accIdSet.add(acc.Id);
        }
        
        List<Opportunity> oppList = [SELECT ID, Name, Amount FROM Opportunity WHERE AccountId In :accIdSet];
        Integer totalAmount =0;
        for(Opportunity opp : oppList)
        {	
            if(opp.Amount != null)
            {
            totalAmount =totalAmount + Integer.valueOf(opp.Amount);
                }
        }
        
        for(Account accRef : accList)
        {
            accRef.TotalOppAmount__c = totalAmount;
            
        }
        totalAmount=0;
    }
    
}