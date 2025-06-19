import getAccountList from '@salesforce/apex/AccountHelperLWC.getAccountList';
import { LightningElement, wire, api } from 'lwc';

export default class WireEcample extends LightningElement {
    @api recordId;

    @wire (getAccountList, {
        accId: '$recordId'
    }) accounts;
}