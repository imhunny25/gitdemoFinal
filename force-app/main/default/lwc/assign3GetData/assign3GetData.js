import { LightningElement, track, api } from 'lwc';
export default class Assign3GetData extends LightningElement {
    @ track viewData = [];
    @track error;
    @api listOpp;   
    @api filterType;
    @api oppToShow;
    @api isStage;
    @api keyChild;
    @api opp = [];
    lastTimeStamp = Date.now();
    @track taskNewList = [];
    @track taskInProgressList = [];
    @track taskCompletedList = [];
    @track dropTaskId;
    @track category;
   

    get isSameStage(){
        //alert('get')
        return this.filterType === this.keyChild;
    }    

    taskDragStart(event) {
        const taskId = event.target.id.substr(0, 18);
        this.dropTaskId = taskId;
        let draggableElement = this.template.querySelector('[data-id="' + taskId + '"]');
        draggableElement.classList += ' drag';
        //console.log('draggableElement AFTER Assign3GetData>>>' + draggableElement.classList);

        const taskIdforParent = new CustomEvent('gettaskid', { detail: taskId });
        this.dispatchEvent(taskIdforParent);
    }

    taskDragEnd(event){
        const taskId = event.target.id.substr(0,18);
        let draggableElement = this.template.querySelector('[data-id="' + taskId + '"]');
        draggableElement.classList.remove('drag');
        //console.log('this.draggableElement after', draggableElement.classList);
    }

    //Animation code
    

    itemDrag(evt) {
    	let interval = 100
    	let curTime = Date.now();
        
        // console.log('this.listopp', this.listOpp[0].Id);
    	if(curTime - this.lastTimeStamp > interval) {
            this.lastTimeStamp = curTime;
            // console.log('this.lastTimeStamp', this.lastTimeStamp);
    		/*const event = new CustomEvent('mousehover', {
	    		detail: {
	    			posX: evt.clientX,
		    		posY: evt.clientY,
		    		category: this.listOpp[0].Id
	    		}
            });*/
            // console.log('event', JSON.stringify(event));
            //this.dispatchEvent(event);
            this.category = this.listOpp[0].Id;
            this.getRect(evt.clientX, evt.clientY, this.category);
            console.log('event dispatch Assign3GetData');
    	}
    	
    }

     
    getRect(posX, posY, category) {
        console.log('getRect is run Assign3GetData');
        console.log('posX' + posX);
        console.log('posY' + posY);
        console.log('category' + category);
        let rect = this.template.querySelector("div.draggable").getBoundingClientRect();
        console.log('rect', JSON.stringify(rect));
        if (this.colliderect(rect, posX, posY)) {
            console.log('inner rect' + rect);
            this.setPadding(true);
        } else {
            this.setPadding(false);
        }
         console.log('rect22222222',JSON.stringify(rect));
    	 return rect;
    }
    
    colliderect(rect, posX, posY) {
        console.log('rect colliderect');
        console.log('posX '+posX+' >>> rect.left'+rect.left);
        console.log('posX ' + posX + '<<<  rect.right' + rect.right);
        console.log('posY ' + posY + '>>>  rect.top' + rect.top);
        console.log('posY ' + posY + '<<<  rect.bottom' + rect.bottom);
        
    	if (posX > rect.left && posX < rect.right && posY > rect.top && posY < rect.bottom) {
            console.log('colliderect inner if');
            return true;
            
        }
        console.log('colliderect outer if');
    	return false;
    }

    setPadding(withHeight) {
        console.log('withHeight::>>>' + withHeight);
        let card = this.template.querySelector("div.draggable")
        console.log('card::>>'+JSON.stringify(card));
        if (withHeight) {
            console.log('inner if');
    		card.style.paddingTop = '177px';
    	}
    	else {
    		card.style.paddingTop = '0px';
    	}
        console.log('dinal');
    }

}