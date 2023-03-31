@isTest
private class SendMailAccountTest {
    @isTest
    static void sendMailAcc()
    {	
        String CRON_N = '0 1 * 14 * ? *';
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<2; i++)
        {
            Account acc = new Account();
            acc.Name = 'Test User';
            accList.add(acc);
        }
        insert accList;
        
        Test.startTest();
        SendMailAccount m = new SendMailAccount();
        String jobID = system.schedule('Account owner send mail', CRON_N, m);
        
    }
    
}