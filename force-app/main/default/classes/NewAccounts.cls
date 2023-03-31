public class NewAccounts {
  public static  void insertData(Integer value)
    {	Integer counter=1;
        List<Account> teaFactory= new List<Account>();
        while(counter<=value)
        {
            Account account= new Account();
            account.AccountNumber='test'+counter;
            Account.Phone='1234'+value;
            Account.Address__c='ajmer'+counter;
            Account.Name='Namste india'+counter;
            
            teaFactory.add(account);
            counter++;
             System.debug(account);
            
        }
        System.debug(teaFactory);
        insert teaFactory;
    }
    

}