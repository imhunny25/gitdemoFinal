@isTest
private class AccountNameUpdateTest {
    @isTest
    static void accNameUpdateTest()
    {
        List<Account>accountList = new List<Account>();
        for(Integer i=0; i<30; i++)
        {
            Account acc = new Account();
            acc.Name = 'Test';
            accountList.add(acc);
        }
        insert accountList;
        //Integer invocation = Limits.getEmailInvocations();
        Test.startTest();
        AccountNameUpdate accoutRef = new AccountNameUpdate();
		Id batchId = Database.executeBatch(accoutRef); 
        Test.stopTest();
        System.assertNotEquals(null, batchId);
        List<Account> accList = [SELECT Id, Name FROM Account];
        System.assertEquals(30, accList.size());
        System.assertEquals('Testing Account', accList[0].Name);
        //System.debug('invocation::>>>>'+invocation);
        //invocation = Limits.getEmailInvocations();
        //System.assertNotEquals(0, invocation);
    }
}