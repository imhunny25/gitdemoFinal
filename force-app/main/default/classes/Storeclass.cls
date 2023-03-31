public with sharing class Storeclass {

    public String tphone { get; set; }

    public Integer tsalary { get; set; }

    public String tsubject { get; set; }

    public String tname { get; set; }

    public PageReference cancel() {
        return null;
    }


    public PageReference insert_record() {
            
            Trainer__c obj=new Trainer__c();
            obj.trainer_name__c=tname;
            obj.subject__c=tsubject;
            obj.salary__c=tsalary;
            obj.phone_number__c=tphone;
             Insert obj;
    
        return null;
    }

}