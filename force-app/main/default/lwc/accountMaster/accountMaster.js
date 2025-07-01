import getAccounts from '@salesforce/apex/AccountContactController.getAccounts';
import { LightningElement, track } from 'lwc';

export default class AccountMaster extends LightningElement {
    @track selectedAccountId;
    @track accountOptions = [];

    connectedCallback(){
        getAccounts().then(data => {
            this.accountOptions = data.map(acc => ({
                label: acc.Name,
                value: acc.Id
            }));
        });
    }

    handleAccountChange(event){
        this.selectedAccountId = event.detail.value;
    }
}
