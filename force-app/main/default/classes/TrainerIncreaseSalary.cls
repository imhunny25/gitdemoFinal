@isTest
public class TrainerIncreaseSalary {
    public static testmethod void main(){
        List<Trainer__c> obj=new List<Trainer__c>();
        obj=[select Salary__c from Trainer__c  where Trainer_Name__c!=null];
        
        for(Trainer__c o:obj){
            o.Salary__c+=1000;
        }
         update obj;
    }
}