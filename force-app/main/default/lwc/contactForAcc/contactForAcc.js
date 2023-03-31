import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAILCON_FIELD from '@salesforce/schema/Contact.Email';
import RATINGCON_FIELD from '@salesforce/schema/Contact.Rating__c';
import PHONECON_FIELD from '@salesforce/schema/Contact.Phone';
import DESCRICON_FIELD from '@salesforce/schema/Contact.Description';
import fetchContactForAccount from '@salesforce/apex/DataController.fetchContactForAccount';

export default class ContactForAcc extends LightningElement {
    contactFields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAILCON_FIELD,RATINGCON_FIELD,PHONECON_FIELD,DESCRICON_FIELD];
    @api accountId;
    @track contact = [];
    header = '';
    subheader = '';
    titletost = '';
    @api objectApiName = '';
    fields = '';

    isShowEditButton = false;
    recordId = '';
    connectedCallback(){

    if ( this.accountId ) {  
        fetchContactForAccount( { accId:this.accountId } )    
        .then(result => {  
            this.contact = result;  
        })  
        .catch(error => {  
             this.error = error;  
        });  
        console.log('this.accounts',JSON.stringify( this.contact));
        } 
    }

    editContactHandler(event)
    {
            this.recordId = event.currentTarget.dataset.id;
            console.log('this.recordId', JSON.stringify(this.recordId));
            this.isShowEditButton = true;
            this.header='Edit Contact';
            this.subheader='Contact Information';
            this.isShowEditButton=true;
            this.objectApiName='Contact';
            this.fields=this.contactFields;
            this.recordId= this.recordId;
            this.titletost='Contact';
    }

    hideModalBox()
    {
        this.isShowEditButton = false;
    }
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: this.titletost+' update',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.isShowNewButton = false;
    }

    handleSubmit(event) {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        console.log('fields',fields);
       
         //fields.LastName = 'My Custom Last Name'; // modify a field
         console.log(this.titletost,'titletost');
         this.template.querySelector('lightning-record-form').submit(fields);
         this.isShowEditButton=false;
    }
}