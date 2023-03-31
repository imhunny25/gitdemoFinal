import { LightningElement, wire, track } from 'lwc';
import searchField from '@salesforce/apex/AccountController.searchField';


export default class ButtonWithDropDownList extends LightningElement {
@track check='Monday';
    tempDayOfWeek =[
        {
            "label" :"Day",
            "value" : ""
        },
        {
          "label": "Monday",
          "value": "Mon"
        },
        {
          "label": "Tuesday",
          "value": "Tue"
        },
        {
          "label": "Wednesday",
          "value": "Wed"
        },
        {
          "label": "Thursday",
          "value": "Thu"
        },
        {
          "label": "Friday",
          "value": "Fri"
        },
        {
          "label": "Saturday",
          "value": "Sat"
        },
        {
          "label": "Sunday",
          "value": "Sun"
        }
      ];
    @track contacts = [];
    @track isfieldListLoadedSearch = false;
    searchInput = '';
    searchInputRef;
    @track buttonDoted = true;
    @track HideDoted = true;
    @track chevrondown = false;
    @track showClose = true;
    @track showDropDown = false;
    @track isListShow = false;

    connectedCallback() {
        this.searchField(null);
        
       
    }

    searchField(searchValue) {
       
        searchField({ searchValue: searchValue })
            .then((result) => {
                if (result.length > 0) {
                    this.isfieldListLoadedSearch = true;
                    this.contacts = result;
                    this.error = undefined;                   
                }else{
                    this.isfieldListLoadedSearch = false;
                }
            })
            .catch((error) => {
                this.error = error;
                this.contacts = undefined;
            });
    }

    isShowListHandler() {
        this.isListShow = true;
        this.copyCode = true;
        this.HideDoted = false;
        this.buttonDoted = false;
        this.chevrondown = true;
        this.contacts = this.filterData;
    }

    HideDotedHandler() {
        this.HideDoted = true;
        this.buttonDoted = true;
        this.isListShow = false;
        this.isfieldListLoadedSearch = false;
        this.showDropDown = false;
        this.searchInput = '';
        this.showClose = true;
    }

    handleFieldSearch(event) {
        this.searchInput =event.target.value;
        this.isfieldListLoaded = false;
        this.isfieldListLoadedSearch = true;
        this.showClose = false;
        this.chevrondown = false;
        this.searchField(this.searchInput.trim());
    }

    handlerChange(event) {
        var searchInputRef = event.currentTarget.dataset.name;
        this.searchInput = searchInputRef;
        this.isfieldListLoadedSearch = false;
        this.showClose = false;
        this.chevrondown = false;
    }

    showDefaultList() {
        if (this.isfieldListLoadedSearch == false) {
            this.isfieldListLoadedSearch = true;
        } else if (this.isfieldListLoadedSearch = true) {
            this.isfieldListLoadedSearch = false;
        }
    }

    clearSearchField(event) {
        this.searchInput = '';
        this.showClose = true;
        this.chevrondown = true;
        this.isfieldListLoadedSearch = false;
    }

    showdrop() {
        if (this.showDropDown == false) {
            this.showDropDown = true;

        } else if (this.showDropDown == true) {
            this.showDropDown = false;
        }
    }

    showDropBlur() {
        //console.log('here on blur');
        // this.showDropDown = false;
    }

    handleSearchBlur() {
        //this.isfieldListLoaded = false;
       //console.log(JSON.stringify( this.template.querySelector('[data-name]')));
       // this.isfieldListLoadedSearch = false;

    }

    showdefaultListBlur() {
        console.log('showdefaultListBlur');
        //this.isfieldListLoaded = false;
    }

    handlerClick()
    {
        console.log('handlerClick...');
        var Day =[];
        this.tempDayOfWeek.forEach(ele =>{
            console.log('ele.......',JSON.stringify(ele));
            if(ele.label == this.check)
            {
                Day.push({label :ele.label, value : ele.value, isSelected :true });
            }else{
                Day.push({label :ele.label, value : ele.value, isSelected :false });
            }
        })
        this.tempDayOfWeek =[...Day];
    }

}