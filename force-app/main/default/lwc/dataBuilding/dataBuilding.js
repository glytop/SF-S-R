import { LightningElement } from 'lwc';

export default class DataBuilding extends LightningElement {
    name = '';
    dateOfBirth = '';
    email = '';

    handleNameChange(event){
        this.name = event.target.value;
    }

    handleDateOfBirthChange(event){
        this.dateOfBirth = event.target.value;
    }

    handleSubmit(event){
        this.email = this.template.querySelector('.input-field').value;
    }
}