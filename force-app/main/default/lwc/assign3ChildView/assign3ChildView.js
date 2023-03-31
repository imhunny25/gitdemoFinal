import { LightningElement, wire , api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getPickListValuesIntoList from '@salesforce/apex/DataController.getPickListValuesIntoList';
import getDataForView from '@salesforce/apex/DataController.getDataForView';
import updateOpportunityDrop from '@salesforce/apex/DataController.updateOpportunityDrop';

export default class Assign3ChildView extends LightningElement {
    pickValue = [];
    @api isStageView = false;
    @api comboVal;
    viewData = [];
    @api istypeview = false;
    @api isstatusview = false;
    @track mapData = [];
    data = [];
    @track taskId;
    @track stage;
    @track type;
    @track status;
    @track comboTypeTwo;

    connectedCallback() {
        this.handlepicklistvalue(this.comboVal);
        
    }

    @api handlepicklistvalue(comboType) {
        this.pickValue = [];
        this.mapData = [];
        if (comboType == 'Stage' || comboType == 'Type' || comboType == 'Status') {
            this.isStageView = true;
        }
        getPickListValuesIntoList({ comboValue: comboType })
        .then(result => {
            this.pickValue = result;
            this.fetchRecords(comboType);
        }).catch(error => {
            const evt = new ShowToastEvent({
                message: this.error.body.message,
            });
            this.dispatchEvent(evt);
        });

    }

    fetchRecords(comboType) {
        this.comboTypeTwo = comboType;
        getDataForView({ listOfData: this.pickValue, filterType: comboType })
        .then(result => {
            for(var key in result){
                this.mapData.push({value:result[key], key:key}); //Here we are creating the array to show on UI.
            }
        });
    }

    // drag and drop
    handleTaskId(event) {
        this.taskId = event.detail;
    }

    handleDrop(event) {
        let dataId = event.currentTarget.dataset.id;
        console.log('dataId::>>>'+dataId);
        if (this.comboVal == 'Stage') {
            this.stage = dataId;
            this.status = null;
            this.type = null;
        } else if (this.comboVal == 'Status')
        {
            this.stage = null;
            this.status = dataId;
            this.type = null;
        } else if (this.comboVal == 'Type')
        {
            this.stage = null;
            this.status = null;
            this.type = dataId;
        }
        this.mapData = [];
        updateOpportunityDrop({ oppId: this.taskId, stage: this.stage, type:this.type, status:this.status })
            .then(result => { 
                console.log('result::>>>' + JSON.stringify(result));
                if (this.comboTypeTwo == 'Stage') {
                    return refreshApex(this.fetchRecords('Stage'));
                }
                 else if (this.comboTypeTwo == 'Type')
                {
                    return refreshApex(this.fetchRecords('Type'));
                 }
                 else if (this.comboTypeTwo == 'Status')
                {
                    return refreshApex(this.fetchRecords('Status'));
                 }
            })
        let draggableElement = this.template.querySelector('[data-role="drop-target"]');
        console.log('draggableElement::>>>>' + draggableElement);
        draggableElement.classList.remove('over');
    }

    handleDragEnter(event) {
        this.cancel(event);
    }

    handleDragOver(event) {
        event.preventDefault();
        let draggableElement = this.template.querySelector('[data-role="drop-target"]');
        draggableElement.classList.add('over');
    }

    handleDragLeave(event) {
        let draggableElement = this.template.querySelector('[data-role="drop-target"]');
        draggableElement.classList.remove('over');
        handleDragEnter();
    }

    //Animation code
    handleMouseHover(evt)
    {
        // console.log('collect mousehover');
        // const event = new CustomEvent('mousehover', {
    	// 	detail: {
    	// 		posX: evt.detail.posX,
	    // 		posY: evt.detail.posY,
	    // 		category: evt.detail.category
    	// 	}
    	// });
        this.handleCollide(evt.detail.posX,evt.detail.posY,evt.detail.category);
        // this.dispatchEvent(event);
       
    }

   
    handleCollide(posX, posY, category) {
        console.log('posX::>>' + posX);
        console.log('posY::>>' + posY);
        console.log('category::>>' + category);
        let allItems = this.template.querySelectorAll("c-assign3-get-data");
        console.log('allItems::>>>'+allItems);
    	for (let item of allItems) {
            let rect = item.getRect();
            console.log('check rect', rect);
    		/*if(this.colliderect(rect, posX, posY)) {
    			item.setPadding(true);
    		} else {
    			item.setPadding(false);
    		}*/
    	}
    }

    colliderect(rect, posX, posY) {
    	/*if (posX > rect.left && posX < rect.right && posY > rect.top && posY < rect.bottom) {
    		return true;
    	}*/
    	return false;
    }

    @api
    resetPaddings() {
    	let allItems = this.template.querySelectorAll("c-dnd-item");
    	for (let item of allItems) {
    		item.setPadding(false);
    	}
    }
}