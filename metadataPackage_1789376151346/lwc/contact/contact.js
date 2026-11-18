import { LightningElement } from 'lwc'; 
import datas from '@salesforce/apex/Contacttable.getContact'; 
const columns = [
    { label:'AccountName',fieldName:'AccountId',type:'Account'},
    { label:'Assistant',fieldName:'AssistantName',type:'test'},
    { label:'Clean Status',fieldName:'CleanStatus',type:'picklist'} 

];
export default class Contact extends LightningElement { 
    data=[];
    columns = columns;
    connectedCallback(){
        datas().then(result=>{
            this.data = result;
        }) 
        .catch(error=>{
            Console.log(error);
        });
    }

}