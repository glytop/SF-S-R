import { LightningElement, api, wire } from 'lwc';
import getContactsBornAfter from '@salesforce/apex/ContactController.getContactsBornAfter';

export default class CallApexImperative extends LightningElement {
    @api minBirthDate;
    handleButtonClick() {
        getContactsBornAfter({
            birthDate: this.minBirthDate
        })
            .then(contacts => {
            })
            .catch(error => {
            });
    }
}