import { LightningElement } from 'lwc';

export default class QuerySelector extends LightningElement {
    
    fname = 'Maks';
    lname = 'Ramanets';


    handleClick(event){
        let input = this.template.querySelectorAll('.input-field'); 

        input.forEach(function(element){
            if (element.name == "firstname"){
                this.fname = element.value;
            } else if (element.name == "lastname"){
                this.lname = element.value
            }
        }, this)
    }
}