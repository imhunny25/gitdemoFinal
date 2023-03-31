import { LightningElement } from 'lwc';

export default class ClearFields extends LightningElement {
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

    handleResetAll(){
        this.template.querySelectorAll('lightning-input').forEach(element => {
          if(element.type === 'checkbox' || element.type === 'checkbox-button'){
            element.checked = false;
          }else{
            element.value = null;
          }      
        });
      }
      handleResetCityField(){
        this.template.querySelector('lightning-input[data-name="city"]').value = null;    
      }
      handleResetUsingDataId(event){
        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
          element.value = null;
        });
      }
      handleResetCheckbox(event){
        //this.template.querySelector('lightning-input[data-name="active"]').checked = false;  
        
        // this.template.querySelector('lightning-input[data-name="active"]').forEach(element => {
        //     if(element.type === 'checkbox' || element.type === 'checkbox-button'){
        //       element.checked = false;
        //     }else{
        //       element.value = null;
        //     }      
        //   });

        const toggleList =this.template.querySelectorAll('lightning-input[data-name="active"]');
        console.log('toggleList.....',JSON.stringify(toggleList));
        for (const toggleElement of toggleList) {
            toggleElement.checked = event.target.checked;
        }
      }
}