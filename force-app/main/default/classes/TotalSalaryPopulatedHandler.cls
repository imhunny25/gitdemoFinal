public class TotalSalaryPopulatedHandler {
    public static void slaryPopulateInsert(List<Account>account)
    {
        Map<Id, Contact> contactMap= new Map<Id, Contact>([Select id, salary__c from Contact]);
        System.debug(contactMap);
    }

}