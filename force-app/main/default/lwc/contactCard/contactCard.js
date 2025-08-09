import { LightningElement, api } from 'lwc';

export default class ContactCard extends LightningElement {
    @api name;
    @api email;
    @api phone;

    selectDetail() {
        const evt = new CustomEvent('select', {
            detail: { email: this.email }
        });
        this.dispatchEvent(evt);
    }
}
