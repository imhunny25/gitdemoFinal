import { LightningElement, api } from 'lwc';
//Import your CSS-File from the Static Resources
// import noHeader from '@salesforce/resourceUrl/NoHeader';
// //Import loadStyle-Method
// import {loadStyle} from "lightning/platformResourceLoader";

export default class Assign3Parent extends LightningElement {
    value = 'none';
    isStage=false;
    isType=false;
    isStatus=false;
    @api
    isChildView = false;

    // connectedCallback() {
    //     loadStyle(this, noHeader)
    //         .then(result => {});
    // }

    get options() {
        return [
            { label: 'Stage', value: 'Stage' },
            { label: 'Status', value: 'Status' },
            { label: 'Type', value: 'Type' },
        ];
    }

    handleChange(event) {
        // console.log('1 isChildView::>>' + this.isChildView);
        this.value = event.detail.value;
        this.isChildView = false;
        if(this.value)
        {
            this.isStage=true;
        }
        this.isChildView = true;
        if (this.isChildView) {
        this.template.querySelectorAll('c-assign3-child-view').forEach(element => {
            element.handlepicklistvalue(this.value);
            })
            // console.log('4 isChildView::>>' + this.isChildView);
        }
    }

    /*handleChildView(event) {
        this.isChildView = event.detail;
    }*/
}