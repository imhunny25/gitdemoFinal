import { LightningElement, api } from 'lwc';

export default class Grid extends LightningElement {
    upperCaseItemName;
    value = 'rishab';
    @api
    get itemName()
    {
        return this.upperCaseItemName;
    }

    set itemName(value)
    {
        console.log('value::>>',value);
        this.upperCaseItemName = value.toUpperCase();
    }
}