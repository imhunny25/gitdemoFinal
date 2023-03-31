import { createRecord } from 'lightning/uiRecordApi';
import { LightningElement, track } from 'lwc';
import salesforcelogo from '@salesforce/resourceUrl/salesforcelogo';
import noHeader from '@salesforce/resourceUrl/noHeader';
//Import loadStyle-Method
import { loadStyle } from "lightning/platformResourceLoader";
import logosvg from '@salesforce/resourceUrl/logosvg';

export default class AccountManagerLDS extends LightningElement {
    svgURL = `${logosvg}#logo`

    @track accountName;
    @track accountPhone;
    @track accountWebsite;

    @track contactFirstName;
    @track contactLastName;
    @track contactPhone;

    salesforcelogourl = salesforcelogo;

    connectedCallback() {
        loadStyle(this, noHeader)
            .then(result => {});
    }
    accountNameHandler(event)
    {
        this.accountName = event.target.value;
       
    }
    accountPhoneHandler(event) {
        this.accountPhone = event.target.value;
    }

    accountWebsiteHandler(event)
    {
        this.accountWebsite = event.target.value;
    }

    contactFirstnameHandler(event){
        this.contactFirstName= event.target.value;
    }

    contactLastnameHandler(event)
    {
        this.contactLastName = event.target.value;
    }

    contactPhoneHandler(event)
    {
        this.contactPhone = event.target.value;
    }

    handleClick()
    {
        const fields = { 'Name': this.accountName, 'Phone': this.accountPhone, 'Website': this.accountWebsite };
        const recordInput = {apiName: 'Account', fields };
        createRecord(recordInput).then(response => {
            console.log('create record succesfully'+ response.id);
        })
            .catch(error => {
                console.log('error', error);
        })
    }

    handleContact()
    {
        const fields = { 'FirstName': this.contactFirstName, 'LastName': this.contactLastName, 'Phone': this.contactPhone };
        const recotdInput = { apiName: 'Contact', fields };
        createRecord(recotdInput).then(response => {
            console.log('Contact created succesfully' + response.id);
        }).catch(error => {
            console.log('Error' + error);
        })
    }



}