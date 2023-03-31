@isTest
private class AccountTriggerHandlerTest {
    
    //Assignment 2: send email owner
    /*  @isTest
public static void test_accountClass()
{
List<Account> accList=new List <Account>();
for(Integer i=1; i<=50; i++)
{
Account acc=new Account( Name = 'Test '+i, Email__c='officialhemraj25@gmail.com');
accList.add(acc);
}
insert accList;
Integer invocation = Limits.getEmailInvocations();
Profile someProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

List<User> userList=new List<User>();
User user=new User();
user.Username = 'testownerchange@gmail.com';
user.FirstName = 'kumawat';
user.LastName = 'Hemraj';
user.Alias = 'Hunny';
user.Email = 'officailhemraj25@gmail.com';
user.TimeZoneSidKey = 'America/New_York';
user.LocaleSidKey = 'en_US';
user.EmailEncodingKey = 'ISO-8859-1';
user.LanguageLocaleKey = 'en_US';
user.ProfileId = someProfile.Id;
insert user;
List<Account> accList1 =new List<Account>([SELECT ID, OwnerId FROM Account LIMIT 10]);
List<Account> accupdate= new List<Account>();
for( Account a : accList1)
{
a.OwnerId = user.Id;
accupdate.add(a);
}
update accupdate;

invocation = Limits.getEmailInvocations();
System.assertNotEquals(0, invocation);

}     */
    
    //Assignment 5 :- contact_infromation fild account object
    /*  @isTest
public static void test_contactIformation()
{
List<Account> accountList=new List<Account>();
for(Integer i=0; i<50; i++)
{
Account accountTest= new Account(Name='Test Contact Information'+i, Contact_Information__c='Name: Avinash Khanwaria, Email: abc@gmail.com, Phone: 9874563210, Company: BAC,');
accountList.add(accountTest);
}
insert accountList;

List<Contact> contactList = new List<Contact>([SELECT Id, Name, Email, Phone, description FROM Contact WHERE AccountId IN :accountList ]);
System.assertEquals('Avinash Khanwaria', contactList[0].name);
System.assertEquals(50, contactList.size());

List<Account> accountUpdateList = new List<Account>([SELECT Id, Name, Contact_Information__c FROM Account]);
List<Account> accountUpdateList1 = new List<Account>();
for(Account accUpdate : accountUpdateList)
{
accUpdate.Contact_Information__c = 'Name: Avinash , Email: abc@gmail.com, Phone: 9874563210, Company: BAC,';
accountUpdateList1.add(accUpdate);
}
update accountUpdateList1;

List<Contact> newContactList = new List<Contact>([SELECT Id, Name, Email, Phone, description FROM Contact WHERE AccountId IN :accountList ]);
System.assertEquals('Avinash', newContactList[0].name);
System.assertEquals(50, newContactList.size());
}
*/
    
    // Assignment :- 10
    
    /*  
@isTest   
public static void test_notUpdatePrestProduct()
{
List<Account> accountList = new List<Account>();
for(Integer i=1; i<50; i++)
{
Account acc = new Account();
acc.Name = 'Test Account '+i;
acc.Present_prods__c = i;
acc.Won_Opportunities__c = i;
accountList.add(acc);
}
insert accountList;
System.assertEquals(1,accountList[0].Present_prods__c );
System.assertEquals(49,accountList[48].Present_prods__c );

List<Account> updateAccountList = new List<Account>([SELECT Id, Name, Won_Opportunities__c, Present_prods__c 
FROM Account]);
for(Account accountUpdate : updateAccountList)
{
accountUpdate.Present_prods__c = 40;
accountUpdate.Won_Opportunities__c = 49;
}
update updateAccountList;

List<Account> accountNewUpdateList = new List<Account>([SELECT Id, Name, Present_prods__c, Won_Opportunities__c
FROM Account]);
System.assertEquals(1,accountNewUpdateList[0].Present_prods__c );
System.assertEquals(1,accountNewUpdateList[0].Won_Opportunities__c);
System.assertNotEquals(1,accountNewUpdateList[45].Present_prods__c );
System.assertNotEquals(1,accountNewUpdateList[45].Won_Opportunities__c);      
}	*/
    
    /*    @isTest
public static void test_billingAdressPopulate()
{
List<Account> acList = new List<Account>();
for(Integer i=0; i<3; i++)
{
Account acc = new Account();
acc.Name = 'Test Trigger Hk'+i;
acc.BillingStreet = ' Test k';
acc.BillingCity = ' use city k';
acc.BillingState = ' us state k';
acc.BillingPostalCode = ' 203030';
acc.BillingCountry = ' uskek';
acList.add(acc);
}
insert acList;

List<Account> updateAccList = new List<Account>([SELECT Id,BillingStreet,ShippingStreet FROM Account]);
System.assertEquals(updateAccList[0].BillingStreet,updateAccList[0].ShippingStreet );
}    */
    
  /*  @isTest
    public static void billingAdressPopulate()
    {
        //List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name = 'Name Account';
        insert acc;
        System.debug('>>>>>>>>>accid'+ acc.Id);
        
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0; i< 5; i++)
        {
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.StageName = 'Value Proposition';
            opp.Name = 'test opportunity';
            opp.CloseDate = system.today().addDays(30);
            oppList.add(opp);
        }
        insert oppList;
        
        List<Opportunity> opp = [SELECT ID, Name FROM Opportunity LIMIT 5];
        for(Opportunity op : opp){
            Test.setCreatedDate(op.Id, System.now().addDays(-32));
        }
        
        List<Account> upAcc = new List<Account>();
        for(Account a : [SELECT Id, Name FROM Account])
        {
            a.Name = 'Test Update';
            upAcc.add(a);
        }
        update upAcc;
    }   */
    
    @isTest
    public static void totalOppAmountAssignmentTest()
    {
        List<Account> accList = new List<Account>();
        for(Integer i=0 ; i<5; i++)
        {
            Account acc = new Account();
            acc.Name = ' Test' + i;
            accList.add(acc);
        }
        insert accList;
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0; i< 5; i++)
        {
            Opportunity opp = new Opportunity();
            opp.AccountId = accList[0].Id;
            opp.StageName = 'Value Proposition';
            opp.Name = 'test opportunity';
            opp.Amount = 5.00;
            opp.CloseDate = System.today();
            oppList.add(opp);
        }
        insert oppList;
        
        List<Account> upAcc = new List<Account>();
        for(Account a : [SELECT Id, Name FROM Account])
        {
            a.Name = 'Test Update';
            upAcc.add(a);
        }
        update upAcc;
       
        List<Account> newDataAccountList = new List<Account>([SELECT id, TotalOppAmount__c FROM Account]);
        System.assertEquals(25, newDataAccountList[0].TotalOppAmount__c );
    }
}