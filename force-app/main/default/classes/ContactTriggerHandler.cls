public class ContactTriggerHandler {
     public static void relateorphinecontact(List<Contact> newContactList){
            List<String> contactLastNameList = new List<String>();
        Map<String, Id> accMap = new Map<String, Id>();
        for(Contact con : newContactList)
        {
            if(con.AccountId == null)
            {
                contactLastNameList.add(con.LastName); 
            }  
        }
        
        if(contactLastNameList != null && contactLastNameList.size() > 0)
        {
            Map<Id, Account> accountDetailsMap = new Map<Id, Account>([SELECT ID, Account_Test_Name__c FROM Account WHERE Account_Test_Name__c IN: contactLastNameList]);
           System.debug('accountDetailsMap>>>>'+accountDetailsMap);
            for(Account acc : accountDetailsMap.values()){
                accMap.put(acc.Account_Test_Name__c, acc.Id);
            }
            System.debug('accMap>>>>>'+accMap);
            
            if(accMap != null && accMap.size() > 0)
            {
                //for(Account acc : accountDetailsList)
                //{
                System.debug('newContactList>>>>'+newContactList);
                    for(Contact c : newContactList)
                    {
                        		System.debug('<<<c.lastName'+c.LastName);
                        		if(accMap.containsKey(c.LastName)){
                                    System.debug('<<accMap.containsKey(c.Name)>>'+accMap.containsKey(c.LastName));
                       			Account Acc=accountDetailsMap.get(c.AccountId);
                            		System.debug('>>>>acc.id'+Acc.Id);
                            	c.AccountId = Acc.Id;
                        }
                    
                }
                  
            }
        }
    }
}
    /*  //Assignment 1 : auto populate
public static void autoPopulateAccountDetails(List<Contact> contacts){ 
Set<Id> accIds = new Set<Id>();
for(Contact con: contacts){            
accIds.add(con.AccountId);   
}
Map<id, Account> acctMap= new Map<Id, Account>([SELECT Id, Website,Email__c, Address__c FROM Account
WHERE Id IN :accIds]);
for(Contact con: contacts)
{
if(acctMap.containsKey(con.AccountId)){ 
Account acc = acctMap.get(con.AccountId);                
con.Email = acc.Email__c;
con.Website__c=  acc.website;
con.Address__c= acc.Address__c; 
}
}   
}

*/
    //Assignment 3: calculate total salary on insert/update
    /*    
public static void salaryCal(List<Contact> contactList, Map<Id,Contact> oldaccMap)
{
Decimal oldSalary=0;        
Set<Id> accountId= new Set<Id>();
for(Contact contact: contactList){
accountId.add(contact.accountId);
}
Map<Id, Account> acctMap1= new Map<Id, Account>([SELECT Id, totalSalary__c FROM Account
WHERE Id IN :accountId]);
for(Contact con: contactList)
{		
if(oldaccMap != null){
oldSalary=oldaccMap.get(con.Id).Salary__c;   
}
if(acctMap1.containsKey(con.AccountId)){   
acctMap1.get(con.AccountId).TotalSalary__c = (acctMap1.get(con.AccountId).Totalsalary__c- oldSalary) + con.Salary__c;
}
}
update acctMap1.values();        
} 
*/
    
    //Assignment 3: calculate total salary on delete
    /*  
public static void deleteContact( List<Contact> oldContactList, Map<Id,Contact> oldaccMap1)
{	
Decimal oldSalary=0;
Set<Id> contactIdSet= new Set<Id>();
for( Contact cont : oldContactList)
{
contactIdSet.add(cont.AccountID);   
}
Map<Id, Account> contactDeleteMap= new Map< Id, Account>([SELECT Id, totalSalary__c FROM Account 
WHERE ID IN :contactIdSet]);
for(Contact contactOld : oldContactList )
{
if(oldaccMap1 != null && oldaccMap1.get(contactOld.Id).Salary__c != null){
oldSalary=oldaccMap1.get(contactOld.Id).Salary__c;   
}
contactDeleteMap.get(contactOld.AccountId).TotalSalary__c = contactDeleteMap.get(contactOld.AccountId).TotalSalary__c - oldSalary;
}
update contactDeleteMap.values();  
}

*/
    
    //Assignment 4: Mark this flag as duplicate on insert/ update if any other existing contact has same website.
    /*  public static void duplicateWebsiteFlag(List <Contact> contactWebsiteList)
{	
List<Contact> conList= new List<Contact>([ SELECT ID, Website__c From Contact]); 
List<String> allWebsites = new List<String>();
for(Contact oldCon :conList){
if(oldCon.Website__c != null){
allWebsites.add(oldCon.Website__c);   
}    
}

for(Contact con : contactWebsiteList )
{
if(con.Website__c != null){
if(allWebsites.size() > 0 && allWebsites.contains(con.Website__c)){
con.Website__c.addError('Website already exists...............!!!');   
}else{
allWebsites.add(con.Website__c);
}    
}

}
} 
*/
    
    // Assignment 4(3) :-Mobile cannot be duplicate for same account.
    /* 
public static void mobileCanNotDuplicateContact(List <Contact> contactMobile)
{
Map<Id , List<String>> accPhoneMap= new Map<Id,  List<String>>();
List <Contact> oldContactList= new List<Contact>([SELECT ID, MobilePhone, AccountId FROM Contact]);
oldContactList.addAll(contactMobile);
for(Contact con :oldContactList)
{
if(con.AccountId != null){
if(accPhoneMap.containsKey(con.AccountId)){
if(con.MobilePhone != null){
accPhoneMap.get(con.AccountId).add(con.MobilePhone);
}
}else{
if(con.MobilePhone != null){
List<String>m1 = new List<String>();
m1.add(con.MobilePhone);
accPhoneMap.put(con.AccountId, m1);
}
}
}
}
for(Contact contacts : contactMobile )
{
if(accPhonemap.containsKey(contacts.AccountId))
{
if(accPhonemap.get(contacts.AccountId).contains(contacts.MobilePhone)  ){
contacts.MobilePhone.addError('duplicate mobile number.......!!!!');
}
}
}
}
*/
    
    //Pretics of Trigger 
    /*  public static void contactAndAccountNameSameEmailPopulate(List<Contact> contactList, List<Contact> oldContactList){
Set<Id> accountIdSet = new Set<Id>();
List<Contact> conList = new List<Contact>();

if(contactList != null){
for(Contact cont : contactList)
{
if( cont.AccountId != null ){
accountIdSet.add(cont.AccountId);
}
}
}

Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, Email__c FROM Account 
WHERE Id IN :accountIdSet ]);
for(Contact cont : contactList)
{	
if(accountMap != null){
Account acc = accountMap.get(cont.AccountId);
if(cont.Email == null )
{
cont.Email.addError('Fill the Value');
}
if(acc.Name == cont.LastName)
{
acc.Email__c = cont.Email;
}
}
}
if(accountMap != null){
update accountMap.values();   
}       

}


public static void deleteContact(List<Contact> oldContactList)
{
Set<Id> accountIdSet = new Set<Id>();
if(oldContactList != Null){
for(Contact cont : oldContactList)
{	
if(cont.AccountId != null)
{
accountIdSet.add(cont.AccountId);
}
}
}
List<Contact> oldContactList1 = new List<Contact>([SELECT Id, AccountId, Email, Name FROM Contact WHERE AccountId In :accountIdSet
Order By CreatedDate DESC]);
Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, NAME FROM Account WHERE Id IN :accountIdSet]);
Map<Id, String> validateAccMap = new Map<Id, String>();
for(Contact contRef : oldContactList1)
{
Account acc = accMap.get(contRef.AccountId);
if(acc.Name == contRef.Name)
{
validateAccMap.put(acc.Id, contRef.Email);
}else if(acc.Name != contRef.Name && validateAccMap.get(acc.Id) == null){
validateAccMap.put(acc.Id, null);
}else if(acc.Name != contRef.Name && validateAccMap == null){
validateAccMap.put(acc.Id, null);
}
}
for(Account acc : accMap.values()){
acc.Email__c = validateAccMap.get(acc.Id);
}
update accMap.values();
}		*/
    
    //Assignment :- 11
  /*  public static void sameRatingNameOfAccountContact(List<Contact> contactList)
    {
        Set<String> ratings = new Set<String>();
        for(Contact con : contactList)
        {
            ratings.add(con.Rating__c);
        }
        Map<Id, Account> allAccountMap = new Map<Id, Account>([SELECT Id, Name, Primary_Contact__c, Rating FROM Account
                                                               WHERE Rating IN :ratings Order By CreatedDate ASC]);
        System.debug('allAccountMap::>>>'+allAccountMap);
        Map<String, Account> ratingMap = new Map<String, Account>();
        for(Account acc : allAccountMap.values())
        {
            ratingMap.put(acc.Name+acc.Rating, acc);
        }
        System.debug('ratingMap::>>>'+ratingMap);
        for(Contact con : contactList)
        {
            String mapKey = '';
            if(con.firstName != null){
                mapKey = con.firstName+con.LastName+con.Rating__c;
            }else{
                mapKey = con.LastName+con.Rating__c;
            }
            Account acc = ratingMap.get(mapKey);
            System.debug('acc::>>>'+acc);
            if(acc != null)
            {
                acc.Primary_Contact__c = con.Id;
            }
        }
        update ratingMap.values();
    }
}*/