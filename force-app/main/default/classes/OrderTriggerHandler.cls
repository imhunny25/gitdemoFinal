public class OrderTriggerHandler {
    public static void oppAndOrder(List<Order>orderList)
    {
        Set<Id> oppSet = new Set<Id>();
        for(Order ord : orderList)
        {
            oppSet.add(ord.opportunityId);
        }
        System.debug('<<<<opportunity>>>>>'+oppSet);
    }

}