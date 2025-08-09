import { LightningElement, api, wire } from 'lwc';
import getContactsBornAfter from '@salesforce/apex/ContactController.getContactsBornAfter';

export default class WireApexProperty extends LightningElement {
    @api minBirthDate;
    // contacts;
    // error;
    
    @wire(getContactsBornAfter, { birthDate: '$minBirthDate' })
    contacts/**
    ({ error, data }){
    if (data) {
    this.contacts = data;
    } else if (error) {
        this.error = error; 
    }
    }    
    */;
}