trigger MyTrigger2 on Course__c (before update) {
    List<Course__c> obj1=new List<Course__c>();
     obj1=Trigger.new;
    
    for(Course__c er1 : obj1)
    {
        if(er1.Duration__c < 40)
        {
            er1.Duration__c.addError(' you can not insert data');
        }else{
            // er1.durastion__c.addError(' you can not insert data');
        }
    }

}