@isTest
public class UpdateParentAccountTest {
    @testSetup
    static void setup()
    {
        List<Account>accounts = new List<Account>();
        accounts.add(new Account(name='Parent'));
        
        for(Integer i=0; i<100; i++)
        {
            accounts.add(new Account(Name = 'Test '+i));
        }
        insert accounts;
    }
    
    @isTest
    static void updateParentAccountTest()
    {
        Id parentId = [SELECT Id FROM Account WHERE Name='Parent'][0].id;
        List<Account> accountList = new List<Account>();
        accountList =[SELECT Id, Name FROM Account WHERE Name like 'Test %'];
        UpdateParentAccount updater = new UpdateParentAccount(accountList, parentId);
        Test.startTest();
        Id JobId = System.enqueueJob(updater);
        Test.stopTest();
        System.assertEquals(100, [select count() from account where parentId = :parentId]);
		        
    }
}