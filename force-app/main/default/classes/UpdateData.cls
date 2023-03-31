@isTest
public class UpdateData {
    public static testmethod void main(){
       List<Employeee__c> em=new List<Employeee__c>();
        em=[select Salary__c from employeee__c];
        for( employeee__c e:em)
        {
            e.salary__c +=100;
        }
		update em;        
        
    }

}