trigger MyTrigger1 on Course__c (before insert) {
    List<Course__c> obj=new List<Course__c>();
    obj=Trigger.new;
    for(Course__c er:obj)
    {
        if(er.fee__c<500)
        {
            er.fee__c.addError(' you cant add the record');
        }else{
           // er.fee__c.addError(' you can add the record');
        }
    }

}