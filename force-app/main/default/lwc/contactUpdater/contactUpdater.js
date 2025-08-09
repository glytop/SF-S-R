import getContact from '@salesforce/apex/ContactUpdaterController.getContact';
import updateContact from '@salesforce/apex/ContactUpdaterController.updateContact';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { LightningElement, api, wire, track } from 'lwc';

export default class ContactUpdater extends LightningElement {
    @api recordId;
    @track contact = {};
    wiredContactResult;

    name;

    onChange(event){
        this.name = event.target.value;
    }

    @wire(getContact, { recordId: '$recordId' })
    wiredContact(result) {
        this.wiredContactResult = result;
        if (result.data) {
            this.contact = { ...result.data };
        } else if (result.error) {
            this.showToast('Error', result.error.body.message, 'error');
        }
    }

    handleChange(event) {
        const { name, value } = event.target;
        this.contact = { ...this.contact, [name]: value };
    }

    async handleSave() {
        await updateContact({ contactToUpdate: this.contact })
            .then(() => {
                this.showToast('Success', 'Contact updated', 'success');
                getRecordNotifyChange([{ recordId: this.recordId }]);
                this.dispatchEvent(new CloseActionScreenEvent());
            })
            .catch(error => {
                this.showToast('Error updating', error.body.message, 'error');
            });
    }
    

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}