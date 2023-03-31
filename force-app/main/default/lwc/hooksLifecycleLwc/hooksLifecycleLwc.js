import { LightningElement, track } from 'lwc';
import getContact from '@salesforce/apex/DataController.getContact';
import { NavigationMixin } from 'lightning/navigation';

export default class HooksLifecycleLwc extends LightningElement {
    @track property;
    @track data = [];

    constructor()
    {
        // define a variable is allowed
        let name = 'Lwc Life Cycle';
        super();
        if (name) {
            this.property = 'Lwc Life Cycle';
        }
        
        // Not allowed :- access the element in the constructor
        let Button = this.template.querySelector('lightning-button');
        console.log(Button);

        // allowed :- we can call apex method in constructor
        getContact()
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.log('error>>>' + error);
            })
        
        // not allowed navigation method in constructor
            // this[NavigationMixin.Navigate]({
            //     type: 'standard__objectPage',
            //     attributes: {
            //         objectApiName: 'Account',
            //         actionName: 'home',
            //     },
            // });

    }
}