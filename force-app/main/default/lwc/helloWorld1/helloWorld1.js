import { LightningElement } from 'lwc';

export default class HelloWorld1 extends LightningElement {

    employee={
        fname: 'Max',
        lname: 'Roma',
        Age: 35,
        City: 'Grodno'
    }

    get getEmployeeRank(){
        const Rank = this.employee.Age >= 50 ? 'Old person' : this.employee.Age >= 30 ? 'Middle age person' : 'Young person';
        return Rank;
    }

}