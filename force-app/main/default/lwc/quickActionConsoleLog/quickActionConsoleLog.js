import { LightningElement, api } from 'lwc';

export default class QuickActionConsoleLog extends LightningElement {
    @api invoke(){
        console.log('Hy Swetee');
    }
}