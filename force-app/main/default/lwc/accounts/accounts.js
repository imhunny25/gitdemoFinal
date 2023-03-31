import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';  
import fetchAccounts from '@salesforce/apex/DataController.fetchAccounts';

const COLUMNS = [  
    { label: 'Id', fieldName: 'Id' },  
    { label: 'Name', fieldName: 'Name' },  
    { label: 'Industry', fieldName: 'Industry' },  
    { type: "button", typeAttributes: {  
        label: 'View',  
        name: 'View',  
        title: 'View',  
        disabled: false,  
        value: 'view',  
        iconPosition: 'left'  
    } },  
    { type: "button", typeAttributes: {  
        label: 'Edit',  
        name: 'Edit',  
        title: 'Edit',  
        disabled: false,  
        value: 'edit',  
        iconPosition: 'left'  
    } }  
];  

export default class Accounts extends NavigationMixin(LightningElement) {
    buttonStatefulState = false;
    buttonIconStatefulState = false;
    showMenu = false;

    handleButtonStatefulClick() {
        this.buttonStatefulState = !this.buttonStatefulState;
    }

    handleButtonIconStatefulClick() {
        this.buttonIconStatefulState = !this.buttonIconStatefulState;
    }

    showHandler(event)
    {
        if (this.showMenu == false)
        {
            this.showMenu = true;
        } else if (this.showMenu == true) {
            this.showMenu = false;
        }
    }

    accounts;  
    error;  
    columns = COLUMNS;  
  
    handleKeyChange( event ) {  
          
        const searchKey = event.target.value;  
  
        if ( searchKey ) {  
  
            fetchAccounts( { searchKey } )    
            .then(result => {  
  
                this.accounts = result;  
  
            })  
            .catch(error => {  
  
                this.error = error;  
  
            });  
  
        } else  
        this.accounts = undefined;  
  
    }      
      
    callRowAction( event ) {  
          
        const recId =  event.detail.row.Id;  
        const actionName = event.detail.action.name;  
        if ( actionName === 'Edit' ) {  
  
            this[NavigationMixin.Navigate]({  
                type: 'standard__recordPage',  
                attributes: {  
                    recordId: recId,  
                    objectApiName: 'Account',  
                    actionName: 'edit'  
                }  
            })  
  
        } else if ( actionName === 'View') {  
  
            this[NavigationMixin.Navigate]({  
                type: 'standard__recordPage',  
                attributes: {  
                    recordId: recId,  
                    objectApiName: 'Account',  
                    actionName: 'view'  
                }  
            })  
  
        }          
  
    }  

}