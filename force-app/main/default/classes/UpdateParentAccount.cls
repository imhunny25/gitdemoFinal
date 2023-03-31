public class UpdateParentAccount implements Queueable {
    private List<Account> accList;
    private Id preantId;
    
    public UpdateParentAccount ( List<Account>record, Id pId)
    {
        this.accList = record;
        this.preantId = pId;
    }
    
    public void execute(QueueableContext context)
    {
        for (Account account : accList) {
          account.parentId = preantId; 
        }
        update accList;
    }
    

}