import  { LightningElement } from 'lwc';  
import getFieldsFromFieldSet from '@salesforce/apex/AccountController.getFieldsFromFieldSet';
import getApexData from '@salesforce/apex/AccountController.getAccount';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
const columns = [

{ label: 'AccountName',fieldName:'Name',type:'text'},

{ label: 'Account Site', fieldName:'Site',type:'text'},

{ label: 'Phone',fieldName:'Phone',type:'phone'},
{ label: 'Website',fieldName:'Website',type:'url'},
{
    type:'action',
    typeAttributes:{
        rowActions:[ 
            { label: 'Edit', name: 'edit'},
            { label: 'Delete', name: 'delete'} 
        ]
    }
}

];

export default class Table extends LightningElement { 

data = [];  
filteredData = []
columns = columns; 
showModal = false;
showEditModal=false;
recordId;
connectedCallback() {  
    getFieldsFromFieldSet()
    .then(result => {
        this.columns = result.map(field =>{
            return{
                label: field.label,
                fieldName: field.apiName, 
                type:'text'
            };
        }); 
        this.columns.push({
            type: 'action',
            typeAttributes: {
                rowActions : [
                    { label: 'Edit', name: 'edit'},
                    { label: 'Delete', name: 'delete'}
                ]
            }
        });
    }) 
    .catch(error =>{
        console.error(error);
    })
    this.loadAccounts(); 
} 
loadAccounts(){

    getApexData().then(result=>{
        this.data = result; 
        this.filteredData = result;
    }) 
    .catch(error=>{
        console.log(error);
    }); 
    

 } 
 handleSearch(event){
     const searchKey = event.target.value.toLowerCase(); 
     console.log('Search:', searchKey) 
     console.log('Toatal Records:', this.data.length);


    this.filteredData = this.data.filter(acc =>
    acc.Name && acc.Name.toLowerCase().includes(searchKey)); 
    console.log('Filtered Records:',this.filteredData.length);
 }
 

 handleNew() {
    this.showModal = true; 
 } 
 handleCancel(){
    this.showModal=false;
 }  
 closeModal(){
    this.showEditModal = false;
 }
 handleSuccess(event){
    this.showModal = false; 
    console.log('Account Created:'+ event.detail.id); 
    this.loadAccounts();
 } 
 handleUpdateSuccess(event){
    this.showEditModal = false; 
    console.log('Account Update:' + event.detail.id); 
    this.loadAccounts();
 } 
 handleUpdateError(event){
    console.error('Update Error:',event.detail);
 }
 handleRowAction(event){
    const actionName = event.detail.action.name;
    const row = event.detail.row;  
    console.log('Action Name:', actionName);
    console.log('Row',JSON.stringify(row));
    console.log('Record Id:',row.Id);
    if(actionName === 'edit'){
        this.recordId = row.Id;
        this.showEditModal = true; 
        console.log('Edit modal opened');
    } 
    if(actionName === 'delete'){
        console.log('Delete clicked');
        deleteRecord(row.Id)
           .then(() => { 
              console.log('Delete Success');

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account Deleted Successfully',
                    variant: 'success'
                })
            );

            this.loadAccounts();
        })
        .catch(error => {
            console.error('Delete Error:',error);
        });
} 
 }
}