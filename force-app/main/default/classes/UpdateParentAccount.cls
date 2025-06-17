/**
 * @description       : 
 * @author            : Maksimilian Ramanets
 * @group             : 
 * @last modified on  : 06-13-2025
 * @last modified by  : Maksimilian Ramanets
**/
public class UpdateParentAccount implements Queueable {
    private List<Account> accList;
    private Id parentAccId;

    public UpdateParentAccount(List<Account> accReccords, Id id){
        this.accList = accReccords;
        this.parentAccId = id;
    }
    
    public void execute(QueueableContext context){
        for (Account acc : accList){
            acc.ParentId = parentAccId; 
        }

        update accList;
    }
}