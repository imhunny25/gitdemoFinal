public with sharing class DataController {
    @AuraEnabled
    public static List<Account> getAccount()
    {
        return[SELECT Id, Name, Phone,AccountNumber, Rating, Email__c,Description From Account Order by CreatedDate DESC];
    }

    @AuraEnabled
    public static List<Contact> getContact()
    {
        return[SELECT Id, FirstName, LastName, Phone, Email, Rating__c, Description FROM Contact Order By CreatedDate DESC];
    }

    @AuraEnabled
    public static List<Opportunity> getOpportunity(){
        try {
           return[SELECT ID, Name, StageName, Amount, Description, CloseDate, Probability FROM Opportunity Order By CreatedDate DESC]; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account> setAccount(String accName, String accNumber, String email, 
                                             String phoneNumber,String accRating, String description)
    {
       List<Account>accountList= new List<Account>();
       Account accountObj = new Account();
       accountObj.Name = accName;
       accountObj.AccountNumber = accNumber;
       accountObj.Email__c = email; 
       accountObj.Rating = accRating;
       accountObj.Phone = phoneNumber;
       accountObj.Description = description;
       accountList.add(accountObj);
       try{
        insert accountList;
       }catch(Exception e)
       {
        throw new AuraHandledException(e.getMessage());
       }
     
       return accountList;
    }

    @AuraEnabled
    public static List<Contact> setContact( String conFirstName, String conLastName, String conEmail, 
                                            String conPhoneNum, String conRating, String conDescription){
                        List<Contact> conList = new List<Contact>();
                        Contact conObj = new Contact();
                        conObj.FirstName = conFirstName;
                        conObj.LastName = conLastName;
                        conObj.email = conEmail;
                        conObj.Phone = conPhoneNum;
                        conObj.Rating__c = conRating;
                        conObj.Description = conDescription;
                        conList.add(conObj);
        try {
            insert conList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return conList;
    }

    @AuraEnabled
    public static List<Opportunity> setOpportunity( String oppName, String closeDate, String stage,
                                         Decimal amount, Integer probability, String descriptionOpp)
    {
        List<Opportunity> oppList= new List<Opportunity>();
        Opportunity oppObj = new Opportunity();
        oppObj.Name = oppName;
        oppObj.CloseDate = Date.parse(closeDate);
        oppObj.StageName = stage;
        oppObj.Amount = amount;
        oppObj.Probability = probability; 
        oppObj.Description = descriptionOpp;
        oppList.add(oppObj);

        try{
            insert oppList;
        }catch (Exception e) {
           throw new AuraHandledException(e.getMessage());
              
        }
        return oppList;
    }

    @AuraEnabled
    public static Account updateAccount( String accName, String accNumber, String accPhone, 
                                                Id accId, String accRating, String accEmail, String accDescription)
    {   Account accountObj = [SELECT Id, Name, AccountNumber, Phone, Description, Rating, Email__c 
                                 FROM Account Where Id =: accId];
            accountObj.Name = accName;
            accountObj.Phone = accPhone;
            accountObj.AccountNumber = accNumber;
            accountObj.Rating = accRating;
            accountObj.Description = accDescription;
            accountObj.Email__c = accEmail;
            update accountObj; 
            return accountObj;    
    } 
    
    @AuraEnabled
    public static Contact updateContact( Id conId, String firstname, String lastname, String rating, 
                                            String phone, String description, String email){
        try {
            Contact con = new Contact();
            con.Id = conId;
            con.FirstName = firstname;
            con.LastName =  lastname;
            con.Phone = phone;
            con.Email = email;
            con.Description = description;
            con.Rating__c = rating;
            update con;
            return con;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Opportunity updateOpportunity(Id oppId, String oppName, String closeDate, String stage,
                                                Decimal amount, Integer probability, String descriptionOpp){
                                                    System.debug('check id ...>>>>'+ oppId);
        try {
            Opportunity opp = new Opportunity();
            opp.Id = oppId;
            opp.Name = oppName;
            opp.CloseDate =  Date.valueOf((String.valueOf(closeDate)));
            opp.StageName = stage;
            opp.Amount = amount;
            opp.Probability = probability; 
            opp.Description = descriptionOpp;
            System.debug('oppId'+ opp.Id);
            update opp;

            return opp;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteAccounts( List<Account> accList){
           try{
           if(accList != null && !accList.isEmpty()){
            delete accList;
           }
        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
           }
    }

    @AuraEnabled
    public static void deleteContacts(List <Contact> conList){
        try {
                if(conList != null && !conList.isEmpty()){
                     delete conList;
                }
        } catch (Exception e) {
           
        }
    }

    @AuraEnabled
    public static void deleteOpportunity(List <Opportunity> oppList){
        try {
            if(oppList != null && !oppList.isEmpty()){
            delete oppList;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<String> getPickListValuesIntoList(String comboValue){
        List<String> pickListValuesList= new List<String>();
         Schema.DescribeFieldResult fieldResult;
         if(comboValue == 'Stage'){
            fieldResult = Opportunity.StageName.getDescribe();
         }else if(comboValue == 'Status'){
            fieldResult = Opportunity.Status__c.getDescribe();
        }else if(comboValue == 'Type'){
            fieldResult = Opportunity.Type.getDescribe();
        }

         List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
         for( Schema.PicklistEntry pickListVal : ple){
             pickListValuesList.add(pickListVal.getLabel());
         }     
         return pickListValuesList;
    }

    @AuraEnabled
    public static  Map<String ,List<OpportunityDetailsList>> getDataForView(List<String> listOfData ,string filterType){
        system.debug('listOfData ===='+listOfData);
        List<Opportunity> viewData = new List<Opportunity>();
        Map<String ,List<OpportunityDetailsList>> mapOfOpp = new Map<String,List<OpportunityDetailsList>>();
        try {
            viewData =[SELECT Name, CloseDate, StageName, Status__c, Id, Type FROM Opportunity 
                        WHERE StageName IN : listOfData 
                        OR 
                        Type IN : listOfData 
                        OR 
                        Status__c IN : listOfData 
                        Order by CreatedDate DESC];  
                       Date datee;
                        for(Opportunity opp : viewData){
                            OpportunityDetailsList oppWrapper = new OpportunityDetailsList();
                            datee = opp.closeDate;
                            oppWrapper.StageName = opp.StageName;
                            oppWrapper.Name = opp.Name;
                            oppWrapper.Type = opp.Type;
                            oppWrapper.Status = opp.Status__c;
                            oppWrapper.closeDate = datee.year() + '/' + datee.month() + '/' + datee.day();
                            oppWrapper.baseUrl = 'https://megnisoft-dev-ed.lightning.force.com/lightning/r/Opportunity/'+opp.Id+'/view';
                            oppWrapper.Id = opp.Id;
                            if(filterType == 'Stage'){
                                if(!mapOfOpp.containsKey(opp.StageName)){
                                    mapOfOpp.put(opp.StageName,new List<OpportunityDetailsList>());
                                }
                                mapOfOpp.get(opp.StageName).add(oppWrapper);
                            }
                            if(filterType == 'Status'){
                                if(!mapOfOpp.containsKey(opp.Status__c)){
                                    mapOfOpp.put(opp.Status__c,new List<OpportunityDetailsList>());
                                }
                                mapOfOpp.get(opp.Status__c).add(oppWrapper);
                            }
                            if(filterType == 'Type'){
                                if(!mapOfOpp.containsKey(opp.Type)){
                                    mapOfOpp.put(opp.Type,new List<OpportunityDetailsList>());
                                }
                                mapOfOpp.get(opp.Type).add(oppWrapper);
                            }
                        }
        } catch (Exception e) {
            system.debug('execption ==='+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
        return mapOfOpp;
    }

    @AuraEnabled
    public static List<Task> getAllTask(){
        Id loggedInUserId = UserInfo.getUserId();
        return [Select Id, Owner.Name, Subject, Status, WhoId, WhatId, Who.Name, What.Name, Description from Task where OwnerId = :loggedInUserId];
    }

    @AuraEnabled
    public static void updateTask(Id newTaskId, String newStatus){
        Task updateTask = new Task(Id = newTaskId, Status = newStatus);
        Database.update(updateTask);
    }

    @AuraEnabled
    public static List<Opportunity> updateOpportunityDrop( String oppId, String type, String status, String stage){
        List<Opportunity> oppList = new List<Opportunity>();
        system.debug('stage>>>>>>'+ stage);
        try {
           Opportunity opp = new Opportunity();
           opp.id = oppId;
           if(type != null)
           {
            opp.type = type;
           }else if(status != null)
           {
            opp.Status__c = status;
           }else if( stage != null)
           {
            opp.StageName = stage;
           }
           
           oppList.add(opp);
           update oppList; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        System.debug('update list'+ oppList);
        return oppList;
    }

    @AuraEnabled( cacheable = true )  
    public static List< Account > fetchAccounts( String searchKey ) {  
        
        String strKey = '%' + searchKey + '%';  
        return [ 
            SELECT Id, Name, Industry 
            FROM Account 
            WHERE Name LIKE: strKey LIMIT 10 
        ];  
            
    }  

    @AuraEnabled  
    public static List< Account > fetchAccountsForContactUpdate( String searchKey ) {  
        
        String strKey = '%' + searchKey + '%';  
        return [ 
            SELECT Id,Name,(SELECT Id, Name, Phone FROM Contacts) FROM Account  
            WHERE Name LIKE: strKey LIMIT 10 
        ];      
    }

    @AuraEnabled
    public static List<Contact> fetchContactForAccount( String accId){
        return [ 
            SELECT Id,Name,Phone FROM Contact  
            WHERE AccountId =:accId
        ];  
    }

    public class opportunityDetailsList{
        @AuraEnabled
        public String StageName{get;set;}
        @AuraEnabled
        public String Type{get;set;}
        @AuraEnabled
        public String Status{get;set;}
        @AuraEnabled
        public String Id{get;set;}
        @AuraEnabled
        public String Name{get;set;}
        @AuraEnabled
        public String baseUrl{get;set;}
        @AuraEnabled
        public String closeDate{get;set;}
    }
}