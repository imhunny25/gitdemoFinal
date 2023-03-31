import { LightningElement, track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ID_FIELD from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNTNUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import EMAIL_FIELD from '@salesforce/schema/Account.Email__c';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';
import ID_FIELDCont from '@salesforce/schema/Contact.Id';
import FIRSTNAME_FIELDCont from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELDCont from '@salesforce/schema/Contact.LastName';
import PHONE_FIELDCont from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELDCont from '@salesforce/schema/Contact.Email';
import Rating_FIELDCont from '@salesforce/schema/Contact.Rating__c';
import DESCRIPTION_FIELDCont from '@salesforce/schema/Contact.Description';
import ID_FIELDOPP from '@salesforce/schema/Opportunity.Id';
import NAME_FIELDOpp from '@salesforce/schema/Opportunity.Name';
import STAGE_FIELDOpp from '@salesforce/schema/Opportunity.StageName';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';
import PROBALITY_FIELD from '@salesforce/schema/Opportunity.Probability';
import CLODEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import DESCRIPTION_FIELDOpp from '@salesforce/schema/Opportunity.Description';
import getAccount from '@salesforce/apex/DataController.getAccount';
import getContact from '@salesforce/apex/DataController.getContact';
import getOpportunity from '@salesforce/apex/DataController.getOpportunity';

const COLUMNS = [
    { label: 'Account Id', fieldName: ID_FIELD.fieldApiName, type: 'id' },
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Phone', fieldName: PHONE_FIELD.fieldApiName, type: 'number' },
    { label: 'Account Number', fieldName: ACCOUNTNUMBER_FIELD.fieldApiName, type: 'number' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'text' },
    { label: 'Rating', fieldName: RATING_FIELD.fieldApiName, type: 'text' },
    { label: 'Description', fieldName: DESCRIPTION_FIELD.fieldApiName, type: 'text' }
];

const contactColumns = [
    {label : 'Contact Id', fieldName :ID_FIELDCont.fieldApiName, type:'id'},
    {label : 'First Name', fieldName: FIRSTNAME_FIELDCont.fieldApiName, type: 'text'},
    {label : 'Last Name', fieldName: LASTNAME_FIELDCont.fieldApiName, type: 'text'},
    {label : 'Phone', fieldName : PHONE_FIELDCont.fieldApiName, type:'number'},
    {label : 'Email', fieldName : EMAIL_FIELDCont.fieldApiName, type:'text'},
    {label : 'Rating', fieldName : Rating_FIELDCont.fieldApiName, type:'text'},
    {label : 'Description', fieldName : DESCRIPTION_FIELDCont.fieldApiName, type:'text'}
];

const oppColumns =[
    {label: 'Opportunity Id', fieldName:ID_FIELDOPP.fieldApiName, type:'id'},
    {label: 'Name', fieldName: NAME_FIELDOpp.fieldApiName, type:'text'},
    {label: 'Stage', fieldName:STAGE_FIELDOpp.fieldApiName, type:'text'},
    {label: 'Amount', fieldName:AMOUNT_FIELD.fieldApiName, type:'text'},
    {label:'Probability', fieldName:PROBALITY_FIELD.fieldApiName, type:'text'},
    {label:'Close Date', fieldName:CLODEDATE_FIELD.fieldApiName, type:'Date'},
    {label:'Description', fieldName:DESCRIPTION_FIELDOpp.fieldApiName, type:'text'}
];

export default class IndexParent extends LightningElement {
    @track columns;
    @track data;
    @track display;
    @track isChildCall = false;
    @track totalAccount = 0;
    @track totalContact =0;
    @track totalOpportunity = 0;
    @api isAccount = false;
    @api isContact = false;
    @api isOpportunitiy = false;
    @api totalSelectedRows=[];
    @api totalupdatedata=[];
    @api totalupdatecdatacont=[];
    

    showClickAccount(){
        // console.log('account click');
        this.isChildCall = false;
        this.data = [];  
        this.columns = [];  
        this.display = 'Display Account Records ';
        this.isAccount = true;
        this.isContact = false;
        this.isOpportunitiy = false;
    getAccount()
       .then(result => {
                //console.log('get account retsut::>>.0'+JSON.stringify(result));
                this.isChildCall = true;
                this.data = result;
                this.columns = COLUMNS;
                this.totalAccount = this.data.length;
                this.totalContact = 0;
                this.totalOpportunity=0;
       })
       .catch(error => {
           console.log('Errorured:- '+error.body.message);
           const evt = new ShowToastEvent({
            message: this.error.body.message,
        });
        this.dispatchEvent(evt);
       });
   }
   
   showClickContact()
   {
            this.isChildCall = false;
            this.data = [];  
            this.columns = [];  
            this.display = 'Display Contact Records';
            this.isAccount = false;
            this.isContact = true;
            this.isOpportunitiy = false;

        getContact().then(result =>{
            this.isChildCall = true;
            this.data = result;
            this.columns = contactColumns;
            this.totalContact = this.data.length;
            this.totalAccount=0;
            this.totalOpportunity=0;
           
    }).catch(error =>{
        console.log('Errorured:- '+error.body.message);
        const evt = new ShowToastEvent({
            message: this.error.body.message,
        });
        this.dispatchEvent(evt);
    })
   }

   showClickOpportunity()
   {
            this.isChildCall = false;
            this.data = [];  
            this.columns = [];  
            this.display = 'Display Opportunity Records';
            this.isAccount = false;
            this.isContact = false;
            this.isOpportunitiy = true;

    getOpportunity().then(result =>{
            this.isChildCall = true;
            this.data = result;
            this.columns = oppColumns;
            this.totalOpportunity = this.data.length;
            this.totalAccount =0;
            this.totalContact=0;
           
    }).catch(error =>{
        console.log('Errorured:- '+error.body.message);
        const evt = new ShowToastEvent({
            message: this.error.body.message,
        });
        this.dispatchEvent(evt);
    })
   }

   // datatable refresh Account
   refreshHandle(event){
        // console.log('event call.......!!!!!! refresh data');
        // console.log('event detail'+event.detail);
        this.data =[];
        this.totalAccount =0;
        this.isChildCall = false;
        if(event.detail == 'Account'){
            getAccount()
            .then(result => {
                // console.log('acc result length'+ result.length);
                this.data = result;
                this.totalAccount =result.length;
                this.totalContact = 0;
                this.totalOpportunity =0;
                this.isChildCall = true;
                // console.log('acc result length'+ result.length);
                })
                .catch(error => {
                // console.log('Errorured:- '+error.body.message);
                const evt = new ShowToastEvent({
                message: this.error.body.message,
                });
                this.dispatchEvent(evt);
            });
        }else if(event.detail == 'Contact'){
            getContact()
            .then(result => {
                // console.log('result length'+ result.length);
                this.data = result;
                this.totalContact =result.length;
                this.totalAccount =0;
                this.totalOpportunity =0;
                this.isChildCall = true;
                // console.log('after this.tabledataresult::>>>'+ result.length);
                })
                .catch(error => {
                // console.log('Errorured:- '+error.body.message);
                const evt = new ShowToastEvent({
                message: this.error.body.message,
                });
                this.dispatchEvent(evt);
            });
        }else if(event.detail == 'Opportunity'){
            // console.log(event,'done dnaa done');
            getOpportunity()
            .then(result => {
                // console.log('result length'+ result.length);
                this.data = result;
                this.totalOpportunity =result.length;
                this.totalAccount = 0;
                this.totalContact =0;
                this.isChildCall = true;
                // console.log('after this.tabledataresult::>>>'+ result.length);
                })
                .catch(error => {
                // console.log('Errorured:- '+error.body.message);
                const evt = new ShowToastEvent({
                message: this.error.body.message,
                });
                this.dispatchEvent(evt);
            });
        }
    }


    selectRows(event)
        {
            // console.log('selectRows....AA', JSON.stringify(event));
            this.totalSelectedRows=event.detail;
            // console.log('selectRows....',JSON.stringify(this.totalSelectedRows));   
        }

}

// https://medium.com/salesforce-champion/lwc-wire-and-imperative-7d008fca7b4e