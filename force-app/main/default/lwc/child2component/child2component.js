import { LightningElement } from 'lwc';
export default class Child2component extends LightningElement { 
    SelectedContact = {
        name:'Mamatha',
        email:'mamatha@gmail.com',
        phone:'9603317815'
    }; 
    /*@description 
    * this method is called when the "Show Contact" button is clicked.
    *it dispatches a custom event name with the slected cocnt we are passing the paramater details :however event cabbn be created wihout it*/ 
    handleShow(){ 
        console.log('Button clicked');
        this.dispatchEvent(new CustomEvent('showcontact',{
            detail:this. SelectedContact
        }));
    }

}