@isTest
private class AddressTriggerHandler_test {
    @isTest
    public static void test_addressCount()
    {	
        List<Contact> contList = new List<Contact>();
        for(Integer i=0; i<2; i++)
        {
            Contact con = new Contact();
            con.LastName=' Test Address '+i;
            con.Phone='1236547896';
            contList.add(con);
        }
        insert contList;
        List<Contact> updateListContact=new List<Contact>([SELECT Id, Name FROM Contact]);
        List<Address__c> addressList = new List<Address__c>();
        for(Integer i=0; i<50; i++)
        {
            Address__c addressForTest = new Address__c();
            addressForTest.Name = 'Mansarover'+i;
            if(i<25){
                addressForTest.isActive__c = true;
            }else{
                addressForTest.isActive__c = false;    
            }  
            addressForTest.Contact__c = updateListContact[0].Id;
            addressList.add(addressForTest);
        }
        insert addressList;
        List<Contact> contactNewUpdate = [SELECT ID, Name, TotalActiveAddress__c, Recent_Active_Address__c FROM Contact];
        System.assertEquals(25, contactNewUpdate[0].TotalActiveAddress__c );
        System.assertEquals( 'Mansarover24',contactNewUpdate[0].Recent_Active_Address__c);
        
        Address__c addressForTest2 = new Address__c();
        addressForTest2.Name = 'Mansarover';
        addressForTest2.isActive__c = false;    
        addressForTest2.Contact__c = updateListContact[1].Id;
        insert addressForTest2;
        List<Contact> contactNewUpdate2 = [SELECT ID, Name, TotalActiveAddress__c, Recent_Active_Address__c FROM Contact];
        System.assertEquals(0, contactNewUpdate2[1].TotalActiveAddress__c );
        System.assertEquals( null , contactNewUpdate2[1].Recent_Active_Address__c);
        
        Address__c addressForTest3 = new Address__c();
        addressForTest3.Name = 'Mansarover2';
        addressForTest3.isActive__c = true;    
        addressForTest3.Contact__c = updateListContact[1].Id;
        insert addressForTest3;
        List<Contact> contactNewUpdate3 = [SELECT ID, Name, TotalActiveAddress__c, Recent_Active_Address__c FROM Contact];
        System.assertEquals(1, contactNewUpdate3[1].TotalActiveAddress__c );
        System.assertEquals( 'Mansarover2' , contactNewUpdate3[1].Recent_Active_Address__c);
    }
}