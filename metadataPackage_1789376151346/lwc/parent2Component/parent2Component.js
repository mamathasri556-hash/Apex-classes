import { LightningElement } from 'lwc';
export default class Parent2Component extends LightningElement { 
    showingContact; 
    handleContactDetail(event){ 
        console.log('Event received');
        console.log(event.detail);
        this.showingContact = event.detail;
    }

}