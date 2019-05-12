import { Component } from '@angular/core';
//import { IonicPage} from 'ionic-angular';


/**
 * Generated class for the OrderListSelectComponent component.
 *
 * See https://angular.io/api/core/Component for more info on Angular
 * Components.
 */

@Component({
  selector: 'order-list-select',
  templateUrl: 'order-list-select.html'
})
export class OrderListSelectComponent {

  text: string;
  testList: any = [
    {testID: 1, testName: " test1", checked: false},
    {testID: 2, testName: " test2", checked: false},
    {testID: 3, testName: "dgdfgd", checked: false},
    {testID: 4, testName: "UricAcid", checked: false}
 ]

selectedArray :any = [];
  constructor() {
    console.log('Hello OrderListSelectComponent Component');
    this.text = 'Hello World';
  }
  checkAll(){
    for(let i =0; i <= this.testList.length; i++) {
      this.testList[i].checked = true;
    }
   console.log(this.testList);
  }
  
  selectMember(data){
   if (data.checked == true) {
      this.selectedArray.push(data);
    } else {
     let newArray = this.selectedArray.filter(function(el) {
       return el.testID !== data.testID;
    });
     this.selectedArray = newArray;
   }
   console.log(this.selectedArray);
  }
}
