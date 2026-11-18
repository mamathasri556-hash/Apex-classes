import { LightningElement } from 'lwc';
export default class Table extends LightningElement { 
    items = ['Apple','banana','Grapes']; 
    fruitOptions = [
        { label: 'Apple', value: 'apple'},
        { label: 'Mango', value: 'mangp'}, 
        { lable :'Orange', value:'orange'}
    ];

}