import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Account.Id';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class LwcPhoneUpdate extends LightningElement {
    @api recordId;
    userInput;

    handleChange(event) {
        this.userInput = event.target.value;
    }

    async handleClick() {

        const fields = {
            [ID_FIELD.fieldApiName]: this.recordId,
            [PHONE_FIELD.fieldApiName]: this.userInput
        };

        const recordInput = {
            fields
        };

        const result = await updateRecord(recordInput);
        console.log(JSON.stringify(result));

        this.dispatchEvent(new CloseActionScreenEvent());
    }
}