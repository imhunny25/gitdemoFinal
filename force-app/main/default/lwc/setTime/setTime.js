import { LightningElement, api, track } from 'lwc';
import saveScheduler from "@salesforce/apex/PostInstallationController.saveScheduler";


export default class SetTime extends LightningElement {

  @track sendOnceSelected = true;
  @track sendRepeatSelected = true;
  @track repeatWeeklySelected = false;
  @track repeatMonthlySelected = false;
  freqOptions = [{ label: 'Weekly', value: 'Weekly' }, { label: 'Monthly', value: 'Monthly' }];
  @track selectedRepeatValue = 'Daily';
  @track clearCache = true;
  @track repeatmonthlyfreq1 = false;
  @track allMonths = [];
  @track repeatmonthlyfreq2 = false;
  @track sendIntervalSelected = false;
  @track repeatIntervalSelected = false;
  @track intervalWeekValue = 0;
  @track recurrenceFrequency = {}
  @track weekly = {};
  @track weekDay = {};
  @track monthly={};
  @track test=[];
  @track isDisabled;

  connectedCallback()
    {  
         for (let i = 0; i <= 12; i++) {
            this.allMonths.push(i);
          }
          this.weekly.weekDay={};
          this.weekly.weekDay.Sunday =false;
          this.weekly.weekDay.Monday =false;
          this.weekly.weekDay.Tuesday =false;
          this.weekly.weekDay.Wednesday =false;
          this.weekly.weekDay.Thursday =false;
          this.weekly.weekDay.Friday =false;
          this.weekly.weekDay.Saturday  =false;
          this.repeatWeeklySelected=true;
    }

    renderedCallback(){
      this.clearCache = true;
  }

  get isRecur1Disabled() {
      return !this.repeatmonthlyfreq1;
    }

    get allMonthsOptions() {
      var monthsOptions = [];
  
      for (let i = 1; i <= 12; i++) {
        monthsOptions.push(i);
      }
  
      return monthsOptions;
    }

  repeatChange(event) {
      try {
        this.clearCache = false;
        var name = event.currentTarget.value;
        this.monthly.dayMonth=undefined;
        this.monthly.weekDayMonth=undefined;
        this.clearValues(".dayMonth", '');
        this.clearValues(".weekDayMonth", '');
  
        if (name == 'repeatmonthlyfreq1') {
          this.monthly.dayMonth={};
          this.repeatmonthlyfreq1 = true;
          this.repeatmonthlyfreq2 = false;
  
        } else if (name == 'repeatmonthlyfreq2') {
         this.monthly.weekDayMonth={};
          this.repeatmonthlyfreq2 = true;
          this.repeatmonthlyfreq1 = false;
  
        }
      } catch (error) {
        console.log('error------',error);
      }
      
    }

    get allDaysNumberOptions() {
      var daysNumbers = [];
  
      for (let i = 1; i <= 31; i++) {
        daysNumbers.push(i);
      }
  
      return daysNumbers;
    }

    get isRecur2Disabled() {
      return !this.repeatmonthlyfreq2;
    }

    handleTest(event)
    {
      var check = event.target.checked;
      var test = event.currentTarget.label;
      if(check == true){
        this.test.push(test);
     }
    }
    handleTest1(event)
    {
      var check = event.target.checked;
      var test = event.currentTarget.label;
      if(check == true){
        this.test.push(test);
     }
    }
    handleTest2(event)
    {
      var check = event.target.checked;
      var test = event.currentTarget.label;
      if(check == true){
        this.test.push(test);
     }
    }

    handleRepeatFreqSelect(e) {
      this.clearCache = false;
      var val = e.currentTarget.value;
    
      let that = this;
      setTimeout(function(){ 
        that.clearValues(".clearWeekDay", 0);
        that.clearValues(".clearInterval", 0);
      }, 
      .05);
  
      if (val == 'Weekly') {
        this.repeatWeeklySelected = true;
        this.repeatMonthlySelected = false;
      }
  
      if (val == 'Monthly') {
        this.repeatWeeklySelected = false;
        this.repeatMonthlySelected = true;
        this.repeatmonthlyfreq1 = true;
        this.repeatmonthlyfreq2 = false;
      }
 
    }
    
    handlePicklistValueChange(event) {
      var name = event.currentTarget.name;
      var day = event.currentTarget.value;

      try {
  
         if (name == 'monthlyWeekNumberRecurOne') {
          this.monthly.dayMonth={};
          this.monthly.dayMonth.day=day;
        } else if (name == 'monthlyWeekNumberRecurTwo') {
          this.monthly.weekDayMonth={};
          this.monthly.weekDayMonth.week=day;
  
        } else if (name == 'dayNameRecurTwo') {
          this.monthly.weekDayMonth.day=day;
  
        } else if (name == 'monthlyMonthNumberRecurTwo') {
          this.monthly.weekDayMonth.month=day;
  
        } else if (name == 'monthlyWeekNumberRecurOne') {
          this.monthly2[0].monthly1.month=day;
          
        }
  
      } catch (error) {
        console.log(error);
      }
  
    }
   

    handleWeeklySelect0(event) {
     
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Sunday = checkNunchecked;
    }
    
    handleWeeklySelect1(event) {
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Monday = checkNunchecked;
    }

    handleWeeklySelect2(event) {
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Tuesday = checkNunchecked;
    }
    
    handleWeeklySelect3(event) {
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Wednesday = checkNunchecked;
    }

    handleWeeklySelect4(event) {
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Thursday = checkNunchecked;
    }

    handleWeeklySelect5(event) {
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Friday = checkNunchecked;
    }

    handleWeeklySelect6(event) {
      var checkNunchecked = event.target.checked;
      this.weekly.weekDay.Saturday = checkNunchecked;
    }



    handleChangeStartDate(event)
    {
      var startDate =event.currentTarget.value;     
      
      if(startDate == undefined || startDate == null || startDate == '') 
      {
        this.isDisabled = true;
      }else{
        this.weekly.startDate = startDate;
        this.monthly.startDate=startDate;
        this.isDisabled = false;
      }
     
    }

    handleChangeEndtDate(event)
    {
      var endDate = event.currentTarget.value;
     
      if (endDate == undefined || endDate == null || endDate == '') 
      {
        this.isDisabled = true;
      }else{
        this.weekly.endDate = endDate;
        this.monthly.endDate=endDate;
        this.isDisabled = false;
      }
     
    }

    clearValues(className, defaultValue){
      try {
        var select = this.template.querySelectorAll(className);      
        var length = select.length;
        for (var i = length-1; i >= 0; i--) {
          select[i].value = defaultValue;
        } 
      } catch (error) {
        console.log('error==',error);
      }
       
    }

    handleClick()
    {
     

      if(this.repeatWeeklySelected == true){
       
        this.recurrenceFrequency.weekly = {};
        this.recurrenceFrequency.weekly = this.weekly;
        this.recurrenceFrequency.weekly.test =[];
        this.recurrenceFrequency.weekly.test=this.test;
        console.log('this.recurrenceFrequency>>>>',JSON.stringify(this.recurrenceFrequency));
        console.log('start date>>>>',this.recurrenceFrequency.weekly.startDate);
        saveScheduler({monthWeekDetials : JSON.stringify(this.recurrenceFrequency)})
        .then((result)=>{
         console.log('result>>>>>>',JSON.stringify(result));
      });

      
      }else if(this.repeatMonthlySelected==true)
      {
        this.recurrenceFrequency.monthly={};
        this.recurrenceFrequency.monthly=this.monthly;
        this.recurrenceFrequency.monthly.test=[];
        this.recurrenceFrequency.monthly.test=this.test;
        console.log('this.recurrenceFrequency>>>>',JSON.stringify(this.recurrenceFrequency));
        saveScheduler({monthWeekDetials : JSON.stringify(this.recurrenceFrequency)})
        .then((result)=>{
         console.log('result>>>>>>',JSON.stringify(result));
      });
       
      }
     
    }

    handleClickCancel()
    {
      this.repeatMonthlySelected=false;
      this.repeatWeeklySelected=false;
    }
}