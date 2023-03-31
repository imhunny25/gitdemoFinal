@isTest
public class FindDuplicate {
    public  static testmethod void checkEmailPhone(){
        					List<Account> fakeQuotes = new List<Account>{
				            new Account(Name = 'Prod 1', AnnualRevenue = 100),
                			new Account(Name = 'Prod 2', AnnualRevenue = 200),
                			new Account(Name = 'Prod 1', AnnualRevenue = 300),
                			new Account(Name = 'Prod 2', AnnualRevenue = 400),
                			new Account(Name = 'Prod 1', AnnualRevenue = 500)
                			};
                               // System.debug(fakeQuotes);
                    
                    Map<String, List<Double>> listPrices = new Map<String, List<Double>>();
       // System.debug(listPrices); blank  map
       
        				for(Account a : fakeQuotes){
            			List<Double> temp = listPrices.get(a.Name);
                            System.debug('<<<<<<<<<listPrices>>>>>>>>'+listPrices.get(a.Name));
                            
            			if(temp == null) {
                			listPrices.put(a.Name, new List<Double>{a.AnnualRevenue});
            			} else {
                			temp.add(a.AnnualRevenue);
            			}
       					}
       					 System.debug(listPrices); // {Prod 1=(100.0, 300.0, 500.0), Prod 2=(200.0, 400.0)}
        
        
    }
}