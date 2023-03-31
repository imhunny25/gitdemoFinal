import { LightningElement,track,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LightningAlert from 'lightning/alert';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNTNUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import EMAIL_FIELD from '@salesforce/schema/Account.Email__c';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAILCON_FIELD from '@salesforce/schema/Contact.Email';
import RATINGCON_FIELD from '@salesforce/schema/Contact.Rating__c';
import PHONECON_FIELD from '@salesforce/schema/Contact.Phone';
import DESCRICON_FIELD from '@salesforce/schema/Contact.Description';
import OPPNAME_FIELD from '@salesforce/schema/Opportunity.Name';
import COLSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';
import PROBABILITY_FIELD from '@salesforce/schema/Opportunity.Probability';
import DESCRIPTIONOPP_FIELD from '@salesforce/schema/Opportunity.Description';
import deleteAccounts from '@salesforce/apex/DataController.deleteAccounts';
import deleteContacts from '@salesforce/apex/DataController.deleteContacts';
import deleteOpportunity from '@salesforce/apex/DataController.deleteOpportunity';


export default class RecordNewEditDelete extends LightningElement {
    @api header='';
    @api subheader='';
    @api iscontactnew;
    @api isopportunitynew;
    @api isaccountnew;
    @api titletost='';
    @track isShowNewButton=false;
    @track isShowEditButton=false;
    @api objectApiName ='';
    @api totalselectrecord;
    fields ='';
    @api recordId;
    accountFields = [NAME_FIELD, ACCOUNTNUMBER_FIELD, EMAIL_FIELD, RATING_FIELD, PHONE_FIELD, DESCRIPTION_FIELD ];
    contactFields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAILCON_FIELD,RATINGCON_FIELD,PHONECON_FIELD,DESCRICON_FIELD];
    oppFields=[OPPNAME_FIELD,COLSEDATE_FIELD,STAGE_FIELD,AMOUNT_FIELD,PROBABILITY_FIELD,DESCRIPTIONOPP_FIELD];
    
    async showModalBoxNew(event)
    {   if(this.isaccountnew == false && this.iscontactnew == false && this.isopportunitynew == false)
        {
            await LightningAlert.open({
                message: 'Please Select Single Object .',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            }); 
        }

        if(this.isaccountnew == true && this.iscontactnew == false && this.isopportunitynew == false)
        {
            this.header='New Account';
            this.subheader='Account Information';
            this.isShowNewButton=true;
            this.objectApiName='Account';
            this.fields=this.accountFields;
            this.titletost='Account';
            
        }else if(this.isaccountnew == false && this.iscontactnew == true && this.isopportunitynew == false)
        {
            this.header='New Contact';
            this.subheader='Contact Information';
            this.isShowNewButton=true;
            this.objectApiName='Contact';
            this.fields=this.contactFields;
            this.titletost='Contact';

        }else if(this.isaccountnew == false && this.iscontactnew == false && this.isopportunitynew == true)
        {
            this.header='New Opportunity';
            this.subheader='Opportunity Information';
            this.isShowNewButton=true;
            this.objectApiName='Opportunity';
            this.fields=this.oppFields;
            this.titletost='Opportunity';
        }
        
    }

    hideModalBox(event)
    {
        this.isShowNewButton=false;
        this.isShowEditButton=false;
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: this.titletost+' created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.isShowNewButton = false;
        
        this.dispatchEvent(new CustomEvent(
            'handlerefresh',{detail: this.titletost}
        ));
        
    }

    async showEditAccount(event)
    {
        if(this.isaccountnew == true && this.iscontactnew == false && this.isopportunitynew == false)
        {
            console.log('totalselectrecordlength', this.totalselectrecord.length);
            if(this.totalselectrecord.length == 1){
            this.header='Edit Account';
            this.subheader='Account Information';
            this.isShowEditButton=true;
            this.objectApiName='Account';
            this.fields=this.accountFields;
            this.recordId=this.totalselectrecord[0].Id;
            this.titletost='Account';
            }else{
                await LightningAlert.open({
                    message: 'Please Select Single Row .',
                    theme: 'error', // a red theme intended for error states
                    label: 'Error!', // this is the header text
                }); 
            }
        }else if(this.isaccountnew == false && this.iscontactnew == true && this.isopportunitynew == false)
        {
            if(this.totalselectrecord.length == 1){
            this.header='Edit Contact';
            this.subheader='Contact Information';
            this.isShowEditButton=true;
            this.objectApiName='Contact';
            this.fields=this.contactFields;
            this.recordId=this.totalselectrecord[0].Id;
            this.titletost='Contact';
            }else{
                await LightningAlert.open({
                    message: 'Please Select Single Row .',
                    theme: 'error', // a red theme intended for error states
                    label: 'Error!', // this is the header text
                });  
            }
        }else if(this.isaccountnew == false && this.iscontactnew == false && this.isopportunitynew == true)
        {   if(this.totalselectrecord.length == 1){
            this.header='Edit Opportunity';
            this.subheader='Opportunity Information';
            this.isShowEditButton=true;
            this.objectApiName='Opportunity';
            this.fields=this.oppFields;
            this.recordId=this.totalselectrecord[0].Id;
            this.titletost='Opportunity';
            }else{
                await LightningAlert.open({
                    message: 'Please Select Single Row .',
                    theme: 'error', // a red theme intended for error states
                    label: 'Error!', // this is the header text
                });  
            }
        }
    }

    handleSubmit(event) {
        event.preventDefault(); // stop the form from submitting
        const fields = event.detail.fields;
        console.log('fields',fields);
       
         //fields.LastName = 'My Custom Last Name'; // modify a field
         console.log(this.titletost,'titletost');
         this.dispatchEvent(new CustomEvent(
             'handlerefresh',{detail: this.titletost}
         ));
         this.template.querySelector('lightning-record-form').submit(fields);
         this.isShowEditButton=false;
    }


    //code for delete account
    async DeleteAccount(event)
    {
        if(this.isaccountnew == false && this.iscontactnew ==false && this.isopportunitynew ==false && this.totalselectrecord == 0){
            await LightningAlert.open({
                message: 'Please Select Single Object .',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            });
        }else{

        if(this.isaccountnew == true && this.iscontactnew ==false && this.isopportunitynew ==false ){
        if(this.totalselectrecord.length >= 1){
        deleteAccounts({
            accList: this.totalselectrecord 
            }).then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message:' records are deleted.',
                        variant: 'success'
                    }),
                    this.dispatchEvent(new CustomEvent(
                        'handlerefresh',{detail: 'Account'}
                    ))
                );
           
        }).catch(error => {            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Select Data Row',
                    message: JSON.stringify(error),
                    variant: 'error'
                }),
            );
        });
    }else{
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Select Data Row',
                // message: JSON.stringify(error),
                variant: 'error'
            }),
        );
    }
    }else if(this.isaccountnew == false && this.iscontactnew ==true && this.isopportunitynew ==false)  {
        if(this.totalselectrecord.length >=1){
        deleteContacts({
            conList: this.totalselectrecord 
            }).then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message:' records are deleted.',
                        variant: 'success'
                    }),
                    this.dispatchEvent(new CustomEvent(
                        'handlerefresh',{detail: 'Contact'}
                    ))
                );
           
        }).catch(error => {            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error Because Account realted another Object',
                    message: JSON.stringify(error),
                    variant: 'error'
                }),
            );
        });
    }else{
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Select Data Row',
                // message: JSON.stringify(error),
                variant: 'error'
            }),
        );
    }
    } else if(this.isaccountnew == false && this.iscontactnew ==false && this.isopportunitynew ==true)
    {
        if(this.totalselectrecord.length >=1){
        deleteOpportunity({
            oppList: this.totalselectrecord 
            }).then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message:' records are deleted.',
                        variant: 'success'
                    }),
                    this.dispatchEvent(new CustomEvent(
                        'handlerefresh',{detail: 'Opportunity'}
                    ))
                );
           
        }).catch(error => {            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error Because Account realted another Object',
                    message: JSON.stringify(error),
                    variant: 'error'
                }),
            );
        });
    }else{
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Select Data Row',
                // message: JSON.stringify(error),
                variant: 'error'
            }),
        );
    }
    }
}
}
}