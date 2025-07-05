import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Account.Id';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class LwcPhoneUpdate extends LightningElement {
    @api recordId;
    userInput;

    handleChange(event){
        this.userInput = event.target.value;
    }

    handleClick(){

        const fields = {};

        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[PHONE_FIELD.fieldApiName] = this.userInput;

        const recordInput = {
            fields: fields
        };

        updateRecord(recordInput).then(result => {
            console.log(JSON.stringify(result));
        }).catch(error => {
            console.log('error: ' + JSON.stringify(error));
        })

        this.dispatchEvent(new CloseActionScreenEvent());
    }
}