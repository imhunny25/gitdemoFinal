import { LightningElement,api, track } from 'lwc';

export default class RecordChildDataTable extends LightningElement {
    @api tabledata=[];
    @api columns='';
    @track items;
    @track startingRecord=1;
    @track page=1;
    @track endingRecord=0;
    @track totalRecordCount;
    totalPage;
    selectedRecords = [];
    refreshTable;
    error;
    @track data;
    pageSize =10;
    @track isShowNext = true;
    @track isShowPrev = true;
    @api updatedatacont=[];
   
    
    connectedCallback(){
        this.items = this.tabledata;
        this.totalRecordCount = this.tabledata.length;
        this.totalPage = Math.ceil(this.totalRecordCount/this.pageSize);
        this.tabledata = this.items.slice(0,this.pageSize);
        this.endingRecord = this.pageSize;
    }
    
     prevHandler(event)
    {
        if(this.page>1 && this.page != 1)
        {
            this.page = this.page-1;
            this.displayRecordPerPage(this.page);
        }
        if(this.page == 1){
            this.isShowPrev = false;
        }
        this.isShowNext = true;
    }

    nextHandler(event)
    {
        if(this.page<this.totalPage && this.page != this.totalPage){
            this.page= this.page+1;
            this.displayRecordPerPage(this.page);
        }
        if(this.page == this.totalPage){
            this.isShowNext = false;
        }
        this.isShowPrev = true;
    }

    displayRecordPerPage(page)
    {
        this.startingRecord = (page - 1) * this.pageSize;
        this.endingRecord = page * this.pageSize;
        this.endingRecord = (this.endingRecord > this.totalRecordCount) ? this.totalRecordCount : this.endingRecord;
        this.tabledata = this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }

    getSelectedRecords(event) {        
        const selectedRows = event.detail.selectedRows;
        console.log(selectedRows,'selectedRows');
        this.recordsCount = event.detail.selectedRows.length;
        console.log(this.recordsCount,'recordCount');
        this.selectedRecords=new Array();
                for (let i = 0; i < selectedRows.length; i++)
                {
                this.selectedRecords.push(selectedRows[i]);
                }  
        console.log(this.selectedRecords,'selectedRecords');
        // make here custome event
        const totalSelectRecord = new CustomEvent(
            'selectrecord',{detail:this.selectedRecords}
        )
        this.dispatchEvent(totalSelectRecord);
        console.log('event dispatch');
    }


}