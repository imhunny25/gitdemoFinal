@isTest
public class ListExampleA {
    
    public static testmethod void main()
    {	boolean result;
        List<Integer>intList = new List<Integer>();
        for(Integer i=0; i<5; i++)
        {
            intList.add(i);
        }
        System.debug(intList);
        
	/*	// Add method
		intList.add(10);
		intList.add(11);
		System.debug(intList);   */
        
    /*    // Add method according to index
        intList.add(2,12);
        intList.add(3,13);
        System.debug(intList);		*/
        
        //addAll method (List)
   /*     List<Integer>anotherListInt = new List<Integer>();
        for(Integer i=0; i< 5; i++)
        {
            anotherListInt.add(i);
        }
        
        intList.addAll(anotherListInt);
        System.debug(intList);				*/
        
   /*     //addAll(Set);
        Set<Integer>intSet = new Set<Integer>();
        for(Integer i=1; i<4; i++)
        {
            intSet.add(i);
        }
        
        intList.addAll(intset);
        System.debug(intList);				*/
        
    /*    //clear method
        intList.clear();
        System.debug(intList);				*/
        
     /*    List<Integer>cloneList = new List<Integer>();
        cloneList=intList.clone();
        System.debug(cloneList);			 */

		List<Integer> newList = new List<Integer>();
     	result= intList.equals(newList);
     	System.debug('::>>result  '+ result);
     	newList= intList.clone();
        result= intList.equals(newList);
     	System.debug('::>>result  '+ result);
     
     //get(Integes)
     	
     	Integer i= intList.get(3);
    	 System.debug('::::>>>>i   '+i);
    	 System.debug('::::>>>>hashcode'+ intList.hashcode());
     //isEmpty()
     result=intList.isEmpty();
     System.debug('::>>isempty()'+ result);
     
    /* //clear()
      intList.clear();
     result=intList.isEmpty();
    System.debug('::>>> clear and isempty()   '+ result);
     
     //getsObjectType()
     sObject obj=[SELECT id, Name from Contact];
     System.debug('< sObject type > '+ obj.getSObjectType());			*/
     
     //remove method
     //
     intList.remove(3);
     System.debug('>>>remove  '+ intList);
     //size
     System.debug(intList.size());
     
     
     List<Integer>numberList =  new List<Integer>();
     numberList.add(44);
     numberList.add(42);
     numberList.add(48);
     numberList.add(34);
     numberList.add(11);
     numberList.addAll(intList);
     numberList.sort();
     System.debug(':::sort:::'+ numberList);
     
     
     numberList.set(4,9900000);
     System.debug(':::>>>set:::>>>' + numberList);
     
        
    }
    

}