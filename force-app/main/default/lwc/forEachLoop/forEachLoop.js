import { LightningElement } from 'lwc';

export default class ForEachLoop extends LightningElement {
    
    getEmployeeRank(age) {
        return age >= 50
            ? 'Old person'
            : age >= 30
            ? 'Middle age person'
            : 'Young person';
    }

    employeeList = [
        {
            fname: 'Max',
            lname: 'Roma',
            Age: 35,
            City: 'Grodno',
            Rank: this.getEmployeeRank(35)
        },
        {
            fname: 'Andrey',
            lname: 'Ketrik',
            Age: 15,
            City: 'Minsk',
            Rank: this.getEmployeeRank(15)
        },
        {
            fname: 'Stas',
            lname: 'Molochko',
            Age: 55,
            City: 'Moskou',
            Rank: this.getEmployeeRank(55)
        }
    ];
}