import { LightningElement, wire, track } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
const COLUMNS = [
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Annual Revenue', fieldName: REVENUE_FIELD.fieldApiName, type: 'currency' },
    { label: 'Industry', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text' }
];
export default class AccountList extends LightningElement {
    
    columns = COLUMNS;
     @wire(getAccounts)
     accounts;

    totalAccount(accounts)
    {
        console.log(accounts.size(),'lengyh');
        
    }

    @track accounts;
    @track error;
   
    @wire( getAccounts )
    wiredAccounts({data, error}){
       
            if(data){
                this.accounts = data;
                console.log(this.accounts,'accounts........');
                this.error = undefined;
            }
            else if (error) {
                this.error = error;
                console.log(this.error,'error........');
                this.accounts = undefined;
            }
            console.log(this.accounts,'accounts........');
        }
       
      
        // https://amitsalesforce.blogspot.com/2018/12/Invoke-Apex-Controller-from-Lightning-Web-Component.html
}