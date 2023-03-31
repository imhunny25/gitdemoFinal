@isTest
public class UpdateRecodCourseFee {
	public static testmethod void main()
    {
        List<Course__c> obj=new List<Course__c>();
        obj=[select fee__c from Course__c];
        
        for( Course__c e:obj)
        {e.Fee__c+=100; 
       
        }
        update obj;
    }
}