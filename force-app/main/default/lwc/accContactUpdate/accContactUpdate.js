import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import fetchAccountsForContactUpdate from '@salesforce/apex/DataController.fetchAccountsForContactUpdate';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNTNUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import EMAIL_FIELD from '@salesforce/schema/Account.Email__c';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';

 
export default class AccContactUpdate extends LightningElement {
    accountFields = [NAME_FIELD, ACCOUNTNUMBER_FIELD, EMAIL_FIELD, RATING_FIELD, PHONE_FIELD, DESCRIPTION_FIELD ];
    @track accounts = [];  
    @api objectApiName = '';
    @api fields = '';
    titletost = '';
    header = '';
    subheader = '';
    error;
    activeSections = ['A', 'C'];
    activeSectionsMessage = '';
    isShowNewButton = false;

    handleSectionToggle(event) {
        const openSections = event.detail.openSections;

        if (openSections.length === 0) {
            this.activeSectionsMessage = 'All sections are closed';
        } else {
            this.activeSectionsMessage =
                'Open sections: ' + openSections.join(', ');
        }
    }
    
    handleKeyChange( event ) {  
        const searchKey = event.target.value;  
        if ( searchKey ) {  
            fetchAccountsForContactUpdate( { searchKey } )    
            .then(result => {  
                this.accounts = result;  
            })  
            .catch(error => {  
                 this.error = error;  
            });  
            console.log('this.accounts',JSON.stringify( this.accounts));
        } else { 
            this.accounts = undefined;  
        }
    }  
    handleClick()
    {
        this.isShowNewButton = true;
        this.header = 'New Account';
        this.subheader = 'Create New Account';
        this.objectApiName = 'Account';
        this.fields = this.accountFields;
        this.titletost = 'Account';
    }
    hideModalBox()
    {
        this.isShowNewButton = false;
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: this.titletost+' created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.isShowNewButton = false;
    }

   
}