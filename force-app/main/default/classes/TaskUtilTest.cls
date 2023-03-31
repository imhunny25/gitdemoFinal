@isTest
public class TaskUtilTest {
	@isTest static void testTaskprirority()
    {
        String pri=TaskUtil.getPrirority('hk');
          System.assertEquals('Normal', pri);
    }
    
    @isTest static void testTaskprirority1()	{
    String pri=TaskUtil.getPrirority('CA');
    System.assertEquals('High', pri);
	}
    
    @isTest static void testTaskPrirority2()
    {
        String pri=TaskUtil.getPrirority('Normal');
            System.assertEquals('Normal', pri);
    }
    
    

}