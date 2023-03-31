public class NumberOfStudentAss2 implements Schedulable{
    public void execute(SchedulableContext ctx) 
    {	
        Set<Id>idSet = new Set<Id>();
        List<Student_First_Class__c> st = new List<Student_First_Class__c>([SELECT Id, Name, Class__c, Class__r.Name FROM
                                                                            Student_First_Class__c]);
        for(Student_First_Class__c sfc :st)
        {
            idSet.add(sfc.Class__C);
        }
        Map<Id, Class__c> classMap = new Map<Id, Class__c>([SELECT Id, Name, Number_of_Students__c FROM Class__c
                                                            WHERE Id IN:idSet ]);
        Integer i=0;
        for(Student_First_Class__c sfdc :st)
        {	
            Class__c cc =classMap.get(sfdc.class__c);
            cc.Number_of_Students__c =  cc.Number_of_Students__c + 1;
        }
        update classMap.values();
    }
    
}