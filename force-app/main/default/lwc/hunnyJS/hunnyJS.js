import { LightningElement } from 'lwc';

export default class HunnyJS extends LightningElement {

    connectedCallback(){
    const array1 = [5, 12, 8, 130, 44];
    const found = array1.find(element => element < 10);
    console.log(found);
    const inventory = [
        { name: "apples", quantity: 2 },
        { name: "bananas", quantity: 0 },
        { name: "cherries", quantity: 5 },
      ];
      const inventory2 = [
        { name: "apples1", quantity: 2 },
        { name: "bananas", quantity: 0 },
        { name: "cherries1", quantity: 5 },
      ];
      let temp =[];
      inventory2.forEach(ele =>{
        if(inventory.find(temp=>{temp.name == ele.name})==null){
            temp.push(ele);
        }

      });
      console.log(temp);
      let temp1 = this.removeDuplicates(inventory, inventory2);
      console.log('temp.......'+JSON.stringify(temp1));
}


removeDuplicates(arr1, arr2) {
  const uniqueArr = [...arr1, ...arr2].reduce((acc, curr) => {
    console.log('acc....'+JSON.stringify(acc));
    console.log('curr....'+JSON.stringify(curr));
    const duplicate = acc.find(item => item.type === curr.type && item.model === curr.model && item.color === curr.color);
    if (!duplicate) {
      acc.push(curr);
    }
    return acc;
  }, []);
  return uniqueArr;
}


}