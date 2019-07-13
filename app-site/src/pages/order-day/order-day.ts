import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

/**
 * Generated class for the OrderDayPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-order-day',
  templateUrl: 'order-day.html',
})
export class OrderDayPage {

dayallnum=3;
showdaynum=1;
timebetween=30*60*1000;
am_num=4;
am_start=8*60*60*1000;
pm_num=4;
pm_start=8*60*60*1000;

//第二用于和后台交互获取订购的相关参数,7月13日，上午八点，9点已经被预约
orderdaylist=[
  1562947200000,
  ["1562976000000",
    "1562979600000"]
];

greeting  = "11";
 isDisabled = false;
 successClass = "text-success"
 hasError = true;
 isSpecial = false;
 messageClasses = {
  "text-success": this.hasError, //false
  "text-danger": this.hasError,  //true
  "text-special": this.isSpecial //true
}



  constructor(public navCtrl: NavController, public navParams: NavParams) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderDayPage');
  }

//测试效果
  onClick(event){
    this.greeting = 'Greeting!!';
    //console.log(event);
    console.log(event.type);
    this.isSpecial=true;
  }

}
