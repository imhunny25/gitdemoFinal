@isTest
public class TrainerDelete {
    public static testmethod void main(){
        List<Trainer__c> obj=new List<Trainer__c>();
        obj=[select Trainer_Name__c from Trainer__c  where Trainer_Name__c=null];
         delete obj;
    }
}