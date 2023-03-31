import { api, LightningElement } from 'lwc';

export default class Dndlist extends LightningElement {
    @api tasklist;
    @api category;

    handleDragOver(evt) {
        evt.preventDefault();
    }

    handleItemDragStart(evt) {
        const event = new CustomEvent('listitemdrag', {
            detail: evt.detail
        });

        this.dispatchEvent(event);
    }

    handleDrop(evt) {
        const event = new CustomEvent('itemdrop', {
            detail: this.category
        });
        
        this.dispatchEvent(event);
    }

    handleMouseHover(evt) {
    	const event = new CustomEvent('mousehover', {
    		detail: {
    			posX: evt.detail.posX,
	    		posY: evt.detail.posY,
	    		category: evt.detail.category
    		}
    	});

    	this.dispatchEvent(event);
    }

    @api
    handleCollide(posX, posY, category) {
    	if(this.category === category) {
    		return
    	}
		let allItems = this.template.querySelectorAll("c-dnd-item");
		console.log('allItems>>>>>>>' + allItems);
    	for (let item of allItems) {
    		let rect = item.getRect();
    		if(this.colliderect(rect, posX, posY)) {
    			item.setPadding(true);
    		} else {
    			item.setPadding(false);
    		}
    	}
    }

	colliderect(rect, posX, posY) {
		console.log('rect >>>' + rect);
		console.log('posY>>>>>>' + posX +'  rect.left >>>' + rect.left);
		console.log('posY>>>>>>' + posY + ' rect.right >>>'+ rect.right);

    	if (posX > rect.left && posX < rect.right && posY > rect.top && posY < rect.bottom) {
    		return true;
    	}
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