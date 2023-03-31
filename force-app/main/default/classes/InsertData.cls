@isTest
public class InsertData {
		public static testmethod void main()
		{
    		employeee__c em=new employeee__c();
            em.Depament_Number__c=10;
           em.JobTitle__c='HR';
            em.Salary__c=100000;
            em.Country__c='india';
            Insert em;
		}
}