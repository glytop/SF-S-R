import getContact from '@salesforce/apex/ContactUpdaterController.getContact';
import updateContact from '@salesforce/apex/ContactUpdaterController.updateContact';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { LightningElement, api, wire, track } from 'lwc';

export default class ContactUpdater extends LightningElement {
    @api recordId;
    @track contact = {};

    @wire(getContact, { recordId: '$recordId' })
    wiredContact ({ error, data }) {
        if (data){
            this.contact = { ...data };
        } else if (error){
            this.showToast('Error', error.body.message, 'error');
        }
    }

    handleChange(event){
        const { name, value } = event.target;
        this.contact[name] = value;
    }

    handleSave(){
        updateContact({ contactToUpdate: this.contact })
            .then(() => {
                this.showToast('Success', 'Contact updated', 'success');
                this.dispatchEvent(new CloseActionScreenEvent());
            })
            .catch(error => {
                this.showToast('Error updating', error.body.message, 'error');
            });
    }

    showToast(title, message, variant){
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}