@isTest
private class ContactTriggerHandlerTest { 
    
    @testSetup static void setup() {
        // Create common test accounts
        List<Account> accountList = new List<Account>();
        for(Integer i=1;i<=10;i++) {
            accountList.add(new Account(Website='www.TestAccount.com' , Email__c='hemrajkmt@gmail.com' ,Rating='Warm',
                                        Address__c='Missing places', Name='TestAccountAssinment'+i));
        }
        insert accountList;        
    }
    
    //Assignment 1 : auto populate
    //@isTest
    /*public static void test_autoPopulateAccountDetails()
    {		     		
        List<Account> accountList = new List<Account>([ SELECT  Id, Website, Email__c, Address__c, Name From Account]);
        List<Contact> conList = new List <Contact>();
        for(Account acc: accountList)
        {
            Contact con = new Contact( LastName = acc.Name, AccountId = acc.Id);
            conList.add(con);
        }
        insert conList;
        List<Contact> conList2 = [SELECT Id, Email, Website__c FROM Contact LIMIT 1];
        System.assertEquals('hemrajkmt@gmail.com', conList2[0].Email);
    }*/
    
    //Assignment 3: calculate total salary
    //@isTest
    /*public static void test_salaryCal()
    {
        Account account =[SELECT ID, TotalSalary__c  FROM Account WHERE Name='TestAccountAssinment1' LIMIT 1];        
        List<Contact> contList= new List<Contact>();
        
        for(Integer i=0; i<20; i++ )
        {   
            Contact con= new Contact();
            con.Salary__c=100;
            con.LastName='Test'+i;
            con.AccountId=account.id;
            contList.add(con);
        }
        insert contList;
        Account updateAccount =[SELECT ID, TotalSalary__c  FROM Account WHERE Name='TestAccountAssinment1' LIMIT 1];
        System.assertEquals(2000,updateAccount.TotalSalary__c );
        
        // code for update salary.....
        List<Contact> contListUpdate= [ SELECT ID, Salary__C, LastName FROM Contact];
        for(Contact contact : contListUpdate )
        {   
            contact.Salary__c=150;
            contact.LastName='Test';
        }
        update contListUpdate;
        Account updateAccount1 =[SELECT ID, TotalSalary__c  FROM Account WHERE Name='TestAccountAssinment1' LIMIT 1];
        System.assertEquals(3000,updateAccount1.TotalSalary__c , ' total salaryyyyy>>>>>>>>>>>>>>');
        
        // code for delete contact.........
        List<Contact> contactListDelete =[ SELECT ID, Salary__c , LastName FROM Contact];
        if(contactListDelete.size()>0)
        {
            delete contactListDelete;  
        }
        
        List<Contact> contactListDelete1 =[ SELECT ID, Salary__c , LastName FROM Contact];
        Account deleteAccount1 =[SELECT ID, TotalSalary__c  FROM Account WHERE Name='TestAccountAssinment1' LIMIT 1];
    }    */
    
    // Assignment 4(2) :-website can not duplicate in contacts
   /* @isTest
    public static void test_duplicateWebsiteFlag()
    {
        List<Contact> contactList= new List<Contact>();
        for(Integer i=1; i<20; i++)
        {
            Contact con= new Contact();
            con.LastName=' DuplicateWebsite'+i;
            con.Website__c='www.google.com';
            contactList.add(con);
        }
        try{
            insert contactList;  
        }catch(Exception e){
            System.debug('getMessage:::>>>'+e.getMessage());
            Boolean expectedExceptionThrown =  e.getMessage().contains('Website already exists...............!!!') ? true : false;
            System.debug('expectedExceptionThrown:::>>>'+expectedExceptionThrown);
			System.AssertEquals(true, expectedExceptionThrown);
        }
    }  */
    
    // Assignment 4(3) :-Mobile cannot be duplicate for same account.
    
 /*  @istest
    public static void test_mobileCanNotDuplicateContact()
    {
        Account accounts= [SELECT Id , Name FROM Account LIMIT 1];
         List<Contact> contactsList1= new List<Contact>();
        for(Integer i=1; i<10; i++)
        {
            Contact con= new Contact();
            con.LastName='TestDuplicate'+i;
            con.Salary__c=100+i;
            //con.AccountId=accounts.Id;
            con.MobilePhone='9876543210';
            contactsList1.add(con);
            System.debug('<><><><><><>');
        }
    //    insert contactsList1;
        System.debug('<<<<contactsList1>>>>>>'+contactsList1);
        
        List<Contact> contactsList= new List<Contact>();
        for(Integer i=1; i<20; i++)
        {
            Contact con= new Contact();
            con.LastName='TestDuplicateMobilePhone'+i;
            con.Salary__c=100+i;
            con.AccountId=accounts.Id;
            con.MobilePhone='9876543210';
            contactsList.add(con);
            System.debug('<><><><><><>');
        }
        try{
            Boolean isInsert = false;
            insert contactsList;
            System.AssertNotEquals(false, isInsert);
            System.debug('<><><><><><>contactsList<><><><>'+contactsList);
        } catch(Exception e){
            System.debug('getMessage:::>>>'+e.getMessage());
            Boolean expectedExceptionThrown =  e.getMessage().contains('duplicate mobile number.......!!!!') ? true : false;
            System.debug('expectedExceptionThrown:::>>>1111111'+expectedExceptionThrown);
			System.AssertEquals(true, expectedExceptionThrown);
        }
    }	*/
    
  /*
    @isTest
    public static void test_deleteContact()
    {
        //List<Account> accountList = new List<Account>([SELECT ID, Name FROM Account]);
        Account accountRef = [SELECT Id, Name, Email__c FROM Account LIMIT 1];
        List<Contact> contactList = new List<Contact>();
        for(Integer i=1; i<10; i++)
        {
            Contact con = new Contact();
            con.LastName = 'TestAccountAssinment'+i;
            con.AccountId = accountRef.Id;
            con.Email = 'test'+i+'@gmail.com';
            contactList.add(con);
        }
        System.debug(':::contactList'+contactList);
        insert contactList;
        Account account = [SELECT Id, Name, Email__c FROM Account LIMIT 1];
        System.assertEquals(contactList[0].Email, account.Email__c);
        Contact con = contactList[0];
        con.Email = 'test@test.com';
        update con;
        Account account2 = [SELECT Id, Name, Email__c FROM Account LIMIT 1];
        System.assertEquals('test@test.com', account2.Email__c);
	    delete con;
        Account accUpdate = [SELECT Id, Name, Email__c FROM Account LIMIT 1];
       	System.assertEquals(null, accupdate.Email__c);        
    }
    
    @isTest
    public static void test_deleteContact2()
    {
        List<Account> accList = [SELECT Id, Name, Email__c FROM Account];
        List<Contact> contactList = new List<Contact>();
        for(Integer i=1; i<=10; i++)
        {
            Contact con = new Contact();
            con.LastName = 'TestAccountAssinment'+i;
            con.AccountId = accList[i-1].Id;
            con.Email = 'test'+i+'@gmail.com';
            contactList.add(con);
        }
        System.debug(':::contactList'+contactList);
        insert contactList;       
        List<Account> updateAccList = [SELECT Id, Name, Email__c FROM Account];
        System.assertEquals(contactList[0].Email, updateAccList[0].Email__c);
        System.assertEquals(contactList[3].Email, updateAccList[3].Email__c);
        System.assertEquals(contactList[6].Email, updateAccList[6].Email__c);
        System.assertEquals(contactList[8].Email, updateAccList[8].Email__c);
    }

*/
    
    @isTest
    public static void test_sameRatingNameOfAccountContact()
    {
        List<Contact> contactList = new List<Contact>();
        for(Integer i=1; i<10; i++)
        {
            Contact con = new Contact();
            con.LastName = 'TestAccountAssinment'+i;
            con.Rating__c = 'Warm';
            contactList.add(con);
        }
        insert contactList;
        List<Account> accoutList = new List<Account>([SELECT ID, Primary_Contact__c, Name, Rating  FROM Account LIMIT 1]);
        System.assertNotEquals(null, accoutList[0].Primary_Contact__c);
        System.assertEquals(contactList[0].Id, accoutList[0].Primary_Contact__c);
        
    }
}