import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { stringify } from '@angular/core/src/render3/util';

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
showdaynum=0;
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

showtodaylist={am:[],pm:[]};



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
    this.getTodaylist();
    

  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderDayPage');
  }


  //获取今天展示的showtodaylist数据
getTodaylist(){
//第一生成上午显示数据
var i=0;
var am_show_list=[];
for(i = 0;i<this.am_num;i++) {
  //这个变量不能放在外面
  var one_time={showtime:"",isorder:false};
  //获取某天日期的时间戳
  let showtime=(new Date(new Date().toLocaleDateString())).valueOf()+this.showdaynum * 24 * 60 * 60 * 1000+this.am_start+i*this.timebetween;
  one_time.showtime=showtime.toString();  
  one_time.isorder=false;
  am_show_list.push(one_time);
  }
//生成上午的时间点
this.showtodaylist.am=am_show_list;
//console.log(this.showtodaylist.am);

}



}
