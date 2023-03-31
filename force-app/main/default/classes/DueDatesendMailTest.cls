@isTest
private class DueDatesendMailTest {
    //public static Date dToday1 = Date.today();
	//public static String dateStr = '0 22 03 '+String.valueOf(dToday1.day())+ ' '+String.valueOf(dToday1.month())+ ' ? '+ String.valueOf(dToday1.year());
	public static String CRON_EXP = '0 0 0 * * ? *';
    @isTest
    static void sendMailDue(){
        Contact con = new Contact(LastName='Test', Email = 'officialhemraj25@gmail.com');
        insert con;
        List<Fee__c> fe = new List<Fee__c>();
        for(Integer i=0; i<1; i++)
        {
            Fee__c f = new Fee__c();
            f.Fee_Amount__c = 40000;
            f.Name = 'Test';
            f.Due_Date__c = System.today().addDays(7);
            f.ContactId__c = con.id;
            fe.add(f);
        }
        insert fe;
        Integer invocation = Limits.getEmailInvocations();
        Test.startTest();
        String jobId = System.schedule('Update LeadSource to DreamForce', CRON_EXP, new DueDatesendMail());
        Test.stopTest(); 
        invocation = Limits.getEmailInvocations();
        System.assertNotEquals(0, invocation);
    }
}