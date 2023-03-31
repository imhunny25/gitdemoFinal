@isTest
private class NumberOfStudentAss2Test {
    public static String CRON_EXP = '0 0 0 * * ? *';
    @isTest
    static void countStudent()
    {
        Class__c cc = new Class__c(Name='A');
        insert cc;
        
        
        List<Student_First_Class__c> sfcList = new List<Student_First_Class__c>();
        for(Integer i=0 ; i<12; i++)
        {
            Student_First_Class__c sfc = new Student_First_Class__c();
            sfc.Name = 'Test';
            sfc.Password__c = '134565';
            sfc.email__c = 'test@gmail.com';
            sfc.class__c = cc.id;
            sfcList.add(sfc);
        }
        insert sfcList;
        
        Class__c c2 = new Class__C(Name = 'B');
        insert c2;
        List<Student_First_Class__c> sfcList1 = new List<Student_First_Class__c>();
        for(Integer i=0 ; i<15; i++)
        {
            Student_First_Class__c sfc = new Student_First_Class__c();
            sfc.Name = 'Test'+i;
            sfc.Password__c = '134565';
            sfc.email__c = 'test@gmail.com';
            sfc.class__c = c2.id;
            sfcList1.add(sfc);
        }
        insert sfcList1;
        
        Test.startTest();
        String jobId = System.schedule('Count student in class', CRON_EXP, new NumberOfStudentAss2());
        Test.stopTest(); 
        
        List<Class__c>ccc = new List<Class__c>([SELECT ID, Number_of_Students__c FROM Class__c]);
        System.assertEquals(12, ccc[0].Number_of_Students__c);
        
        List<Class__c>cc1 = new List<Class__c>([SELECT ID, Number_of_Students__c FROM Class__c WHERE Name='B']);
        System.assertEquals(15, cc1[0].Number_of_Students__c);
    }
}