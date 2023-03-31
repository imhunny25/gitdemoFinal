import { LightningElement,track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LightningAlert from 'lightning/alert';
import setAccount from '@salesforce/apex/DataController.setAccount';
import updateAccount from '@salesforce/apex/DataController.updateAccount';
import updateContact from '@salesforce/apex/DataController.updateContact';
import updateOpportunity from '@salesforce/apex/DataController.updateOpportunity';
import setContact from '@salesforce/apex/DataController.setContact';
import setOpportunity from '@salesforce/apex/DataController.setOpportunity';
import deleteAccounts from '@salesforce/apex/DataController.deleteAccounts';
import deleteContacts from '@salesforce/apex/DataController.deleteContacts';
import deleteOpportunity from '@salesforce/apex/DataController.deleteOpportunity';


export default class FormComponent extends LightningElement {
    contact={};
    @api isaccountnew;
    @api iscontactnew;
    @api isopportunitynew;
    @api accName='';
    @api accNumber='';
    @api accPhone='';
    @api oppAmout='';
    @api accEmail='';
    @api accRating='';
    @api accountName='';
    @api accountNumber='';
    @api accountEmail='';
    @api accountRating='';
    @api accountPhone='';
    @api accountDescription='';
    @api accountId ='';
    @api contactId ='';
    @api contactFirstName='';
    @api contacLastName='';
    @api contactEmail='';
    @api contactRating='';
    @api contactPhone='';
    @api contactDescription='';
    @api opportunityId='';
    @api oppName ='';
    @api oppAmount = '';
    @api oppProbability='';
    @api oppDescription ='';
    @track accDec = '';
    @track isShowAccount = false;
    @track isShowAccountEdit= false;
    @track isShowContactEdit=false;
    @track isShowAccountDelete = false;
    @track isShowOpportunity= false;
    @track isShowOpportunityEdit = false;
    @api closedateopp='2022-10-19';
    @api totalselectrecord = [];
    @api errormessage;
    @api newAccount ='';
    @api subheader ='';
    @api lable_name='';
    @api lable_number='';
    @api label_email='';
    @api label_rating='';
    @api label_phone='';
    @api label_description='';
    @api placeholder_accName='';
    @api placeholder_accNumber='';


//------------------------------------------------ new button    
    showModalBox()
    {  
        // this code for new account model
            if(this.isaccountnew == true && this.iscontactnew ==false && this.isopportunitynew ==false){
            this.isShowAccount = true;
            this.header = 'New Account';
            this.subheader ='Account Information';
            this.lable_name = 'Account Name';
            this.lable_number='Account Number';
            this.label_email='Email';
            this.label_rating='Rating';
            this.label_phone='Phone Number';
            this.label_description='Description';
            this.placeholder_accName='Account Name';
            this.placeholder_accNumber='Account Number';
        }
        
        // this code for new contact model
        if(this.isaccountnew == false && this.iscontactnew ==true && this.isopportunitynew ==false){
            this.isShowAccount = true;
            this.header = 'New Contact';
            this.subheader ='Contact Information';
            this.lable_name = 'First Name';
            this.lable_number='Last Name';
            this.label_email='Email';
            this.label_rating='Rating';
            this.label_phone='Phone Number';
            this.label_description='Description';
            this.placeholder_accName='First Name';
            this.placeholder_accNumber='Last Name';
            this.accName='';
            this.accNumber='';
            this.accEmail='';
            this.accPhone='';
            this.accRating='';
            this.accDec='';
        }

        // this code for new opportunity model
        if(this.isaccountnew == false && this.iscontactnew ==false && this.isopportunitynew ==true){
            this.isShowOpportunity = true;
        }
    }

    hideModalBox() {  
        this.isShowAccount = false;
        this.isShowOpportunity = false;
        this.accName='';
        this.accNumber='';
        this.accEmail='';
        this.accPhone='';
        this.accRating='';
        this.accDec='';
        this.oppAmout='';
    }

//code pick list --rating ---start
    get options() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }
//code pick list --rating ---end

//code pick list --stage ---start
    get optionsOpp() {
        return [
            { label: 'Prospecting', value: 'Prospecting' },
            { label: 'Qualification', value: 'Qualification' },
            { label: 'Needs Analysis', value: 'Needs Analysis' },
            { label: 'Value Proposition', value: 'Value Proposition' },
            { label: 'Id. Decision Makers', value: 'Id. Decision Makers' },
            { label: 'Perception Analysis', value: 'Perception Analysis' },
            { label: 'Proposal/Price Quote', value: 'Proposal/Price Quote' },
            { label: 'Negotiation/Review', value: 'Negotiation/Review' },
            { label: 'Closed Won', value: 'Closed Won' },
            { label: 'Closed Lost', value: 'Closed Lost' },
            { label: 'Got Payment', value: 'Got Payment' },
            { label: 'Got Partial Payment', value: 'Got Partial Payment' },
        ];
    }

//code picke list---stage--update
get optionsOppUpdate() {
    return [
        { label: 'Prospecting', value: 'Prospecting' },
        { label: 'Qualification', value: 'Qualification' },
        { label: 'Needs Analysis', value: 'Needs Analysis' },
        { label: 'Value Proposition', value: 'Value Proposition' },
        { label: 'Id. Decision Makers', value: 'Id. Decision Makers' },
        { label: 'Perception Analysis', value: 'Perception Analysis' },
        { label: 'Proposal/Price Quote', value: 'Proposal/Price Quote' },
        { label: 'Negotiation/Review', value: 'Negotiation/Review' },
        { label: 'Closed Won', value: 'Closed Won' },
        { label: 'Closed Lost', value: 'Closed Lost' },
        { label: 'Got Payment', value: 'Got Payment' },
        { label: 'Got Partial Payment', value: 'Got Partial Payment' },
    ];
}

//code pick list --stage ---end

    Ratinghandle(event) {
        this.accRating = event.target.value;
    }

    handle_Account_Name(event)
    {
        this.accName = event.target.value;
       
    }

    handle_Account_Number(event)
    {
      
        this.accNumber = event.target.value;
      
    }

    handle_Account_Email(event)
    {
        this.accEmail = event.target.value;
      
    }

    handle_Account_Phone(event)
    {
        this.accPhone = event.target.value;
       
    }
    description_handler(event){
        this.accDec = event.target.value;
    }

    handle_Amount(event)
    {
        this.oppAmout = event.target.value;
    }

    // isInputValid() {
    //     // console.log('isInputValid is run.......')
    //     let isValid = true;
    //     let inputFields = this.template.querySelectorAll('.validate');
    //     console.log('inputFields queryselector',inputFields );
    //     inputFields.forEach(inputField => {
    //         if(!inputField.checkValidity()) {
    //             inputField.reportValidity();
    //             isValid = false;
    //         }
    //         this.contact[inputField.name] = inputField.value;
    //     });
    //     return isValid;
    // }

    async handleSaveClick(event)
    {
        if(this.isaccountnew == false && this.iscontactnew ==false && this.isopportunitynew ==false ){
            await LightningAlert.open({
                message: 'Please Select Single Object .',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            });
        }
        if(this.isaccountnew == true && this.iscontactnew ==false && this.isopportunitynew ==false) {
        
        const totalSelectRecord = new CustomEvent(
            'handlerefresh',{detail: 'Account'}
        )
        this.dispatchEvent(totalSelectRecord);
     
        setAccount({
            accName : this.accName, accNumber:this.accNumber, email : this.accEmail, phoneNumber:this.accPhone, accRating:this.accRating, description:this.accDec
        }).then(result=>{
          
            const event = new ShowToastEvent({
                title: 'Account created',
                message: 'New Account '+ this.accName +' '+ this.accNumber + ' '+this.accPhone+' created.',
                variant: 'success'
            });
            this.dispatchEvent(event);
            this.isShowAccount = false;
            this.dispatchEvent(new CustomEvent(
                'handlerefresh',{detail: 'Account'}
            ));
           
        })
        .catch(error => {
            // console.log('err:>>>'+JSON.stringify(error));
            const event = new ShowToastEvent({
                title : 'Error',
                message : 'Error creating Account. Please Contact System Admin',
                variant : 'error'
            });
            this.dispatchEvent(event);
        });
        this.accName='';
        this.accNumber='';
        this.accEmail='';
        this.accPhone='';
        this.accRating='';
        this.accDec='';        

        }

        if(this.isaccountnew == false && this.iscontactnew == true && this.isopportunitynew ==false)
    {
        setContact({
            conFirstName : this.accName, conLastName:this.accNumber, conEmail : this.accEmail, conPhoneNum:this.accPhone, 
            conRating:this.accRating, conDescription:this.accDec
        }).then(result=>{
          
            const event = new ShowToastEvent({
                title: 'Contact created',
                message: 'New Contact '+ this.accName +' '+ this.accNumber + ' '+this.accPhone+' created.',
                variant: 'success'
            });
            this.dispatchEvent(event);
            this.isShowAccount = false;
            this.dispatchEvent(new CustomEvent(
                'handlerefresh',{detail: 'Contact'}
            ));
          
        })
        .catch(error => {
          
            const event = new ShowToastEvent({
                title : 'Error',
                message : 'Error creating Contact. Please Contact System Admin',
                variant : 'error'
            });
            this.dispatchEvent(event);
        });
        }

        if(this.isaccountnew == false && this.iscontactnew == false && this.isopportunitynew == true)
         { 
            //  if(this.isInputValid()) {
            //     console.log('hello this is run');
            //  }
        if(this.accName =='' || this.accNumber =='' || this.accRating =='')
        {
            await LightningAlert.open({
                message: 'Required Missing Field .',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            });
        }else{

        setOpportunity({
            oppName :this.accName, closeDate:this.accNumber, stage: this.accRating, amount:this.oppAmout,
            probability:this.accPhone, descriptionOpp:this.accDec
        }).then(result=>{
          
            const event = new ShowToastEvent({
                title: 'Opportunity created',
                message: 'New Opportunity '+ this.accName +' '+ this.accNumber + ' '+this.accPhone+' created.',
                variant: 'success'
            });
            this.dispatchEvent(event);
            this.isShowOpportunity = false;
            this.dispatchEvent(new CustomEvent(
                'handlerefresh',{detail: 'Opportunity'}
            ));
            
        })
        .catch(error => {
            // console.log('error--->>', error);
            const event = new ShowToastEvent({
                title: 'Error Occurred Submitting For Approval',
                message: error.message,
                variant: 'error',
                mode: 'dismissable',
            });
            this.dispatchEvent(event);
        });
        this.accName='';
        this.accNumber='';
        this.accEmail='';
        this.accPhone='';
        this.accRating='';
        this.accDec='';
        this.oppAmout='';
        }}
    }

//------------------------------------------------------- edit account button
 // code for account edit_____________________________________________________________________
 
 async showEditAccount(event)
    {
        if(this.isaccountnew == false && this.iscontactnew ==false && this.isopportunitynew ==false ){
            await LightningAlert.open({
                message: 'Please Select Single Object .',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            });
        }

        if(this.isaccountnew == true && this.iscontactnew ==false && this.isopportunitynew ==false ){
           
            if(this.totalselectrecord.length > 1 || this.totalselectrecord.length == 0)
            {  
                this.isShowAccountEdit = false;
                    await LightningAlert.open({
                        message: 'Please Select Single Data Row .',
                        theme: 'error', // a red theme intended for error states
                        label: 'Error!', // this is the header text
                    });
            }else if(this.totalselectrecord.length == 1){
                this.isShowAccountEdit = true;
                this.accountName= this.totalselectrecord[0].Name;
                this.accountNumber= this.totalselectrecord[0].AccountNumber;
                this.accountPhone= this.totalselectrecord[0].Phone;  
                this.accountEmail= this.totalselectrecord[0].Email__c;
                this.accountRating= this.totalselectrecord[0].Rating;
                this.accountDescription = this.totalselectrecord[0].Description;
                this.accountId = this.totalselectrecord[0].Id;
            }  
        }
    
        else if(this.isaccountnew == false && this.iscontactnew ==true && this.isopportunitynew ==false){
           
            if(this.totalselectrecord.length > 1 || this.totalselectrecord.length == 0)
            {  
                this.isShowAccountEdit = false;
                    await LightningAlert.open({
                        message: 'Please Select Single Data Row .',
                        theme: 'error', // a red theme intended for error states
                        label: 'Error!', // this is the header text
                    });
            }else if(this.totalselectrecord.length == 1){
                this.isShowContactEdit=true;
                this.contactId = this.totalselectrecord[0].Id;
                this.contactFirstName = this.totalselectrecord[0].FirstName;
                this.contactLastName =this.totalselectrecord[0].LastName;
                this.contactEmail = this.totalselectrecord[0].Email;
                this.contactPhone = this.totalselectrecord[0].Phone;
                this.contactRating = this.totalselectrecord[0].Rating__c;
                this.contactDescription = this.totalselectrecord[0].Description;
            }
        }else if(this.isaccountnew == false && this.iscontactnew ==false && this.isopportunitynew ==true){
           
            if(this.totalselectrecord.length > 1 || this.totalselectrecord.length == 0)
            {  
                this.isShowOpportunityEdit = false;
                    await LightningAlert.open({
                        message: 'Please Select Single Data Row .',
                        theme: 'error', // a red theme intended for error states
                        label: 'Error!', // this is the header text
                    });
            }else if(this.totalselectrecord.length == 1 ){
                this.isShowOpportunityEdit = true;
                this.opportunityId = this.totalselectrecord[0].Id;
                this.oppName = this.totalselectrecord[0].Name;
                this.oppAmount =this.totalselectrecord[0].Amount;
                this.oppProbability = this.totalselectrecord[0].Probability;
                this.oppDescription = this.totalselectrecord[0].Description;
                this.value = this.totalselectrecord[0].StageName;
                this.closedateopp = this.totalselectrecord[0].CloseDate;
            }
        }
    
    }
    
    

    hideModalBoxEdit() {  
        this.isShowAccountEdit = false;
        this.isShowContactEdit = false;
        this.isShowOpportunityEdit = false;

    }

    accountNameField(event){
        this.accountName = event.target.value;
    }

    accountNumberField(event)
    {
        this.accountNumber= event.target.value;
    }

    accountEmailField(event)
    {
        this.accountEmail=event.target.value;
    }

    Ratinghandle_Field(event)
    {
        this.accountRating= event.target.value;
    }

    accountPhoneField(event){
        this.accountPhone = event.target.value; 
    }

    accountDescriptionField(event){
        this.accountDescription = event.target.value; 
    }

    contactfirstNameField(event){
        this.contactFirstName = event.target.value;
    }

    contaclastNameField(event){
        this.contacLastName = event.target.value;
    }

    contactEmailField(event)
    {
        this.contactEmail = event.target.value;
    }

    contactRatingField(event){
        this.contactRating = event.target.value;
    }

    contactPhoneField(event){
        this.contactPhone = event.target.value;
    }

    contactDescriptionField(event)
    {
        this.contactDescription = event.target.value;
    }

    handler_opportunity_Name(event)
    {
        this.oppName=event.target.value;
    }

    handler_opportunity_closedate(event)
    {
        this.closedateopp = event.target.value;
    }

    handler_opportunity_stage(event)
    {
        this.value=event.target.value;
    }

    handler_opportunity_amount(event)
    {
        this.oppAmount = event.target.value;
    }

    handler_opportunity_Probability(event)
    {
        this.oppProbability = event.target.value;
    }

    handler_opportunity_description(event)
    {
        this.oppDescription = event.target.value;
    }


    handleUpdateRecord(event)
    {
        if(this.isaccountnew == true && this.iscontactnew ==false && this.isopportunitynew ==false) {
            this.showEditAccount = true;
            updateAccount({ accName : this.accountName, accNumber : this.accountNumber, accPhone : this.accountPhone,
                accRating : this.accountRating, accEmail : this.accountEmail, accDescription : this.accountDescription,
                accId : this.accountId
            }).then(result=>{
                // console.log("result"+JSON.stringify(result));
                const event = new ShowToastEvent({
                    title: 'Account Update',
                    message: 'Update Account '+ this.accountName +' '+ this.accountNumber + ' '+this.accountPhone+' updated.',
                    variant: 'success'
                });
                this.dispatchEvent(event);
                this.isShowAccountEdit = false;
                this.dispatchEvent(new CustomEvent(
                    'handlerefresh',{detail: 'Account'}
                ));
                // console.log('dispatch event account');
            })
            .catch(error => {
                // console.log('err:>>>'+JSON.stringify(error));
                const event = new ShowToastEvent({
                    title : 'Error',
                    message : 'Error Updating Account. Please Contact System Admin',
                    variant : 'error'
                });
                this.dispatchEvent(event);
            });
            
        } else if(this.isaccountnew == false && this.iscontactnew == true && this.isopportunitynew ==false){
            updateContact({ firstname : this.contactFirstName, lastname : this.contacLastName, rating : this.contactRating,
                phone : this.contactPhone, description : this.contactDescription, email : this.contactEmail,
                conId : this.contactId
            }).then(result=>{
                // console.log("result"+JSON.stringify(result));
                const event = new ShowToastEvent({
                    title: 'Contact Update',
                    message: 'Update Contact '+ this.contactFirstName +' '+ this.contacLastName + ' '+this.contactPhone+' updated.',
                    variant: 'success'
                });
                this.dispatchEvent(event);
                // console.log('event dispatch contact' )
                this.isShowContactEdit = false;
                this.isShowAccountEdit = false;
                this.dispatchEvent(new CustomEvent(
                    'handlerefresh',{detail: 'Contact'}
                ));
                // console.log('dispatch event contact');
            })
            .catch(error => {
                // console.log('err:>>>'+JSON.stringify(error));
                const event = new ShowToastEvent({
                    title : 'Error',
                    message : 'Error Updating Contact. Please Contact System Admin',
                    variant : 'error'
                });
                this.dispatchEvent(event);
            });
        }
    }

    handleSaveClickOpp(event)
    {
        if(this.isaccountnew == false && this.iscontactnew == false && this.isopportunitynew ==true){
           
            updateOpportunity({oppId:this.opportunityId, oppName : this.oppName, closeDate :this.closedateopp,
                            stage : this.value, amount:this.oppAmount, probability:this.oppProbability, descriptionOpp:this.oppDescription
                }).then(result=>{
                    // console.log("result"+JSON.stringify(result));
                    const event = new ShowToastEvent({
                        title: 'Opportunity Update',
                        message: 'Update Opportunity '+ this.oppName +' '+ this.oppAmount + ' '+this.oppProbability+' updated.',
                        variant: 'success'
                    });
                    this.dispatchEvent(event);
                    this.isShowOpportunityEdit = false;
                    this.dispatchEvent(new CustomEvent(
                        'handlerefresh',{detail: 'Opportunity'}
                    ));
                    // console.log('dispatch event Opportunity');
                })
                .catch(error => {
                    // console.log('err:>>>'+JSON.stringify(error));
                    const event = new ShowToastEvent({
                        title : 'Error',
                        message : 'Error Updating Opportunity. Please Contact System Admin',
                        variant : 'error'
                    });
                    this.dispatchEvent(event);
                });
        }
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