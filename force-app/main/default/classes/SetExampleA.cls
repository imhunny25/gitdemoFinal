@isTest
public class SetExampleA {
	public static testmethod void setmethods()
    {
        Set<String> setString = new Set<String>{'a','b','d'};
        System.debug(setString);
        setString.add('c');
        System.debug(setString);
        
        List<String>intList = new List<String>{'e','f'};
        
        setString.addAll(intList);
        System.debug(setString);
        
        Boolean result = setString.contains('c');
        System.debug(result);
        
        
        Set<String> setString1 = new Set<String>{'a','b','d'};
        boolean result1= setString.containsAll(setString1);
        System.debug('::>>> result1'+ result1);
        
        boolean result3=setString.equals(setString1);
        System.debug('>>>result3'+result3);
        
        System.debug(' setString    '+ setString);
        System.debug(' setString1    '+ setString1);
        
        
        
       
        setString1.removeAll(setString);
        System.debug('<<<:::'+ setString1);
         System.debug(' setString    '+ setString);
         System.debug(' setString1    '+ setString1);
        
        
        Set<integer> mySet = new Set<integer>{1, 2, 3};
		List<integer> myList = new List<integer>{1, 3};
		Boolean result4 = mySet.retainAll(myList);
        System.debug(result4);
		System.assertEquals(true, result4);
        
        
         
    }
}