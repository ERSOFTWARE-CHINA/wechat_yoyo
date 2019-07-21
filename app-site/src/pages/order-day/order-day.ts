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


//这是些基本参数
dayallnum=3;
showdaynum=0;//显示第几天
timebetween=30*60*1000;
am_num=4;
am_start=8*60*60*1000;
pm_num=4;
pm_start=14*60*60*1000;

//后台反馈已预订的时间点，日期（时间戳），时间点（时间戳）
orderdaylist=[
  1563206400000,
  ["1563235200000",    
    "1563258600000",
  "1563260400000"]
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
//生成上午的时间点
this.showtodaylist.am=this.showlist(this.am_num,this.showdaynum,this.am_start);
//console.log(this.showtodaylist.am);
//生成下午的时间点
this.showtodaylist.pm=this.showlist(this.pm_num,this.showdaynum,this.pm_start);
//console.log(this.showtodaylist.pm);

//对后台反馈数据处理并对已选择的时间点表示出来
this.show_odered_list(this.orderdaylist);
}


showlist(Num,showdaynum,am_start){
  var i=0; 
  var am_show_list=[];
  for(i = 0;i<Num;i++) {
    //这个变量不能放在外面
    var one_time={showtime:"",isorder:false};
    //获取某天日期的时间戳
    let showtime=(new Date(new Date().toLocaleDateString())).valueOf()+showdaynum * 24 * 60 * 60 * 1000+am_start+i*this.timebetween;
    one_time.showtime=showtime.toString();  
    one_time.isorder=false;
    am_show_list.push(one_time);
    }
  return am_show_list;
}


show_odered_list(orderdaylist:any){
  for (var i = 0; i < orderdaylist[1].length; i ++) {   ​
     var down_num=null;
      //判断下午
     down_num=(orderdaylist[1][i]-orderdaylist[0]-this.am_start)/this.timebetween;
     if(down_num>=0&&down_num<=this.am_num){
      this.showtodaylist.am[down_num].isorder=true;
     }

      //判断下午
      down_num=(orderdaylist[1][i]-orderdaylist[0]-this.pm_start)/this.timebetween;
      if(down_num>=0&&down_num<=this.pm_num){
        this.showtodaylist.pm[down_num].isorder=true;
      }



     // console.log(someArray[i]); // 1, "string", false
    ​
    }
}

}
