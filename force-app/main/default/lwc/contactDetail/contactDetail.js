import getContactsByAccountId from '@salesforce/apex/AccountContactController.getContactsByAccountId';
import { LightningElement, wire, api } from 'lwc';

export default class ContactDetail extends LightningElement {
    @api accountId;
    @wire(getContactsByAccountId, { accountId: '$accountId' }) contacts;

    columns = [
        { label: 'First Name', fieldName: 'FirstName', type: 'text' },
        { label: 'Last Name', fieldName: 'LastName', type: 'text' },
        { label: 'Email', fieldName: 'Email', type: 'email' },
    ];
}
