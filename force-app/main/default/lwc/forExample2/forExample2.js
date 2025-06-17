import { LightningElement } from 'lwc';

export default class ForExample2 extends LightningElement {
    text = '';
    handleChange(event){
        this.text = event.target.value;
     }
}