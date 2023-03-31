import { LightningElement, track } from 'lwc';

export default class ButtonSection extends LightningElement {
    @track isShowModal = false;

    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    showNewAcreComponent = false;
    handleClick() {
    this.showNewAcreComponent = true;
}
}