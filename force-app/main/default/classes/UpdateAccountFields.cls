global class UpdateAccountFields implements Database.Batchable<sObject>{
    global final String Query;
    global final String Entity;
    global final String Field;
    global final String Value;
    global final String faxVal;
    
    global UpdateAccountFields(String q, String e, String f, String v, String ff)
    {
        Query=q;
        Entity=e;
        Field=f;
        Value=v;
        faxVal=ff;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope)
    {
        for(Account s : scope)
        {
            s.put(Field,Value);
            s.put('Fax', faxVal);
            //s.Fax = fax;
        }      
        update scope;
    }
    
    global void finish(Database.BatchableContext BC)
    {
        
    }
}

/* 
 using this code on enoymous window for run
String q = 'SELECT Industry,fax FROM Account LIMIT 10';
    String e = 'Account';
    String f = 'Industry';
    String v = 'Consulting';
    String ff = '353453664';
    Id batchInstanceId = Database.executeBatch(new UpdateAccountFields(q,e,f,v,ff), 5);
*/