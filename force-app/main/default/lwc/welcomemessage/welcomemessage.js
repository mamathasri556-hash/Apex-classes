import { LightningElement } from 'lwc';
export default class Welcomemessage extends LightningElement {
           testMethod(){
            console.log('Welcome to Lwc');  
           } 
           showMessage = false;
            handleClick(){ 
                this.showMessage = true;
                console.log('Button clicked');
            } 
               item =['Apple','Bananas']; 

           }