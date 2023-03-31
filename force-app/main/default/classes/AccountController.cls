public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Name, AnnualRevenue, Industry
            FROM Account
            ORDER BY Name
        ];
    }
    // @AuraEnabled(cacheable=true)
    // public static Integer totalAccount()
    // {
    //     return[SELECT count()
    //     FROM Account];
    // }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return [
            SELECT Name, Id
            FROM Contact
            ORDER BY Name
        ];
    }

    @AuraEnabled
    public static List<Contact> searchField(String searchValue) {
        System.debug('searchValue>>>>'+searchValue);
        List<Contact> conList = new List<Contact>();
        if(searchValue == null || searchValue=='undefined'|| searchValue==' ' || searchValue=='' )
        {
            System.debug('searchValue>>>>>>>'+searchValue);
          conList= [ SELECT Name FROM Contact ];  
            System.debug('conList>>>>'+conList);
        }else if(searchValue !=null && searchValue != ' '){
           String strKey = '%' + searchValue + '%';  
           System.debug('>>strKey>>>'+strKey);
        conList= [ SELECT Id,Name FROM Contact WHERE Name LIKE: strKey LIMIT 10  ];  
        System.debug('conList>>>>>'+conList);
        
        }
        return conList;
    }

}