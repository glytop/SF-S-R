import { LightningElement, track } from 'lwc';

export default class ContactList extends LightningElement {
    @track contacts = [];

    setContactsDetail(event) {
        this.contacts = event.detail;
    }
}
