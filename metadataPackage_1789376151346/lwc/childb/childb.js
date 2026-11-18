import { LightningElement } from 'lwc';
export default class Childb extends LightningElement { 
    handleClick(){
        const event = new CustomEvent('notify',{
            detail:{ message: 'Hello from Component B!'}
        }) 
        this.dispatchEvent(event);
    }

}