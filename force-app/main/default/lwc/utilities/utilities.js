import { LightningElement,track } from 'lwc';
import noHeader from '@salesforce/resourceUrl/noHeader';
import avtar from '@salesforce/resourceUrl/avtar';
import img from '@salesforce/resourceUrl/img';
import chevronrighticon from '@salesforce/resourceUrl/chevronrighticon';
//Import loadStyle-Method
import { loadStyle } from "lightning/platformResourceLoader";

export default class Utilities extends LightningElement {
    avtarurl = avtar;
    imgUrl = img;
    chevronright = `${chevronrighticon}#chevronicon`;
    connectedCallback() {
        loadStyle(this, noHeader)
            .then(result => {});
    }
   
    @track selectedOption;
    // changeHandler(event) {
    // const field = event.target.name;
    // if (field === 'optionSelect') {
    //     //this.selectedOption = event.target.value;
    //         alert("you have selected : ",this.selectedOption);
    //     } 
    // }

  

}