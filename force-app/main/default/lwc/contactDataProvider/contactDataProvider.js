import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactDataProvider extends LightningElement {
    contacts = [];
    error;

    @wire(getContacts)
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data;
            this.dispatchEvent(new CustomEvent('contactsready', {
                detail: this.contacts
            }));
        } else if (error) {
            this.error = error;
            this.dispatchEvent(new CustomEvent('dataerror', {
                detail: error
            }));
        }
    }
}
