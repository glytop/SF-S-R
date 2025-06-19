import { LightningElement, track } from 'lwc';
import findAccounts from '@salesforce/apex/CustomerSearchController.findAccounts';

export default class CustomerSearch extends LightningElement {
    @track searchKey = '';
    @track results = [];

    handleInputChange(event) {
        this.searchKey = event.target.value;
        if (this.searchKey.length >= 2) {
            findAccounts({ searchKey: this.searchKey })
                .then(data => {
                    this.results = data;
                })
                .catch(error => {
                    console.error('Error in Search:', error);
                });
        } else {
            this.results = [];
        }
    }
}
