@isTest
public class FetchDataCourse {
    public static testmethod void main(){
        List<Course__c> obj=new List<Course__c>();
    obj=[ select Trainer_Name__c,Trainer_Phone__c,Number_of_student__c,Fee__c,Duration__c from Course__c];
        
    for(Course__c e: obj)
    {
        System.debug(e);
    }
    
    
    
    }
}