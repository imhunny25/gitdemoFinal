import { LightningElement, api } from 'lwc';

export default class Dnditem extends LightningElement {
    @api task;
    lastTimeStamp = Date.now();

    itemDragStart(evt) {
        const event = new CustomEvent('itemdragstart', {
            detail: this.task.taskid
        });

        this.dispatchEvent(event);
    }

    itemDrag(evt) {
    	let interval = 100
    	let curTime = Date.now();

    	if(curTime - this.lastTimeStamp > interval) {
    		this.lastTimeStamp = curTime;
    		const event = new CustomEvent('mousehover', {
	    		detail: {
	    			posX: evt.clientX,
		    		posY: evt.clientY,
		    		category: this.task.category
	    		}
			});
			console.log('task',JSON.stringify( this.task));
			console.log('catergory', this.task.category);
			console.log('event dis', JSON.stringify(event));
	    	this.dispatchEvent(event);
    	}
    	
    }

    @api
	getRect() {
		console.log('getRect is run');
		console.log('sdcsdcsd::>>>>', JSON.stringify(this.template.querySelector("li.draggable")));
		let rect = this.template.querySelector("li.draggable").getBoundingClientRect();
		console.log('getRect is run',JSON.stringify( rect));
		return rect;
		
    }

    @api
    setPadding(withHeight) {
    	let card = this.template.querySelector("li.draggable")
    	if(withHeight) {
    		card.style.paddingTop = '77px';
    	}
    	else {
    		card.style.paddingTop = '0px';
    	}
    	
    }
}