@isTest
public class ArrayAccount {
 		public static  testmethod void main(){
      		  Account[] acc= new Account[4];
            
            	Account a1= new Account();
            	a1.name='Hemraj Kumawat';
            	a1.Fax='44444';
            
            	Account a2= new Account();
            	a2.Address__c='jaipur';
            	a2.AccountNumber='2345';
            
            	Account a3=new Account();
            	a3=a1;
            
           		Account a4=new Account();
            	a4=a2;
            
            	acc[0]=a1;
            	acc[1]=a2;
            	acc[2]=a3;
            	acc[3]=a4;
            
            for(Account a:acc)
            {
                System.debug(a);
            }
            
            
            	
        
    }
}