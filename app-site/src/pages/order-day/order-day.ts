import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { stringify } from '@angular/core/src/render3/util';
import { BusService } from '../../share/bus.service';

import { getDate, getDateAfterDays } from '../../utils/datetime';
import { AppointmentService } from './service';

@IonicPage()
@Component({
  selector: 'page-order-day',
  templateUrl: 'order-day.html',
})
export class OrderDayPage implements OnInit {

  technician: any = null;
  selectedDate: string;
  minDate: string;
  maxDate: string;

  times = [
    { value: "09:00", enabled: false }, { value: "09:30", enabled: false }, { value: "10:00", enabled: false },
    { value: "10:30", enabled: false }, { value: "11:00", enabled: false }, { value: "11:30", enabled: false },
    { value: "12:00", enabled: false }, { value: "12:30", enabled: false }, { value: "13:00", enabled: false },
    { value: "13:30", enabled: false }, { value: "14:00", enabled: false }, { value: "14:30", enabled: false },
    { value: "15:00", enabled: false }, { value: "15:30", enabled: false }, { value: "16:00", enabled: false },
    { value: "16:30", enabled: false }, { value: "17:00", enabled: false }, { value: "17:30", enabled: false },
    { value: "18:00", enabled: false }, { value: "18:30", enabled: false }, { value: "19:00", enabled: false },
    { value: "19:30", enabled: false }, { value: "20:00", enabled: false }, { value: "20:30", enabled: false }
  ]
  
  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams,
    private srv: AppointmentService,
    public bus: BusService) {
    this.getTodaylist();
  }

  ngOnInit() {
    this.technician = this.bus.technicianToBeBook;
    this.minDate = getDate();
    this.maxDate = getDateAfterDays(5);
    this.selectedDate = this.minDate;
    this.getAppointmentData();
  }

  getAppointmentData() {
    // this.srv.list().then(resp => console.log(resp))
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderDayPage');
  }


  //获取今天展示的showtodaylist数据
getTodaylist(){
// //生成上午的时间点
// this.showtodaylist.am=this.showlist(this.am_num,this.showdaynum,this.am_start);
// //console.log(this.showtodaylist.am);
// //生成下午的时间点
// this.showtodaylist.pm=this.showlist(this.pm_num,this.showdaynum,this.pm_start);
// //console.log(this.showtodaylist.pm);

// //对后台反馈数据处理并对已选择的时间点表示出来
// this.show_odered_list(this.orderdaylist);
}


showlist(Num,showdaynum,am_start){
  // var i=0; 
  // var am_show_list=[];
  // for(i = 0;i<Num;i++) {
  //   //这个变量不能放在外面
  //   var one_time={showtime:"",isorder:false};
  //   //获取某天日期的时间戳
  //   let showtime=(new Date(new Date().toLocaleDateString())).valueOf()+showdaynum * 24 * 60 * 60 * 1000+am_start+i*this.timebetween;
  //   one_time.showtime=showtime.toString();  
  //   one_time.isorder=false;
  //   am_show_list.push(one_time);
  //   }
  // return am_show_list;
}


show_odered_list(orderdaylist:any){
  // for (var i = 0; i < orderdaylist[1].length; i ++) {   ​
  //    var down_num=null;
  //     //判断下午
  //    down_num=(orderdaylist[1][i]-orderdaylist[0]-this.am_start)/this.timebetween;
  //    if(down_num>=0&&down_num<=this.am_num){
  //     this.showtodaylist.am[down_num].isorder=true;
  //    }

  //     //判断下午
  //     down_num=(orderdaylist[1][i]-orderdaylist[0]-this.pm_start)/this.timebetween;
  //     if(down_num>=0&&down_num<=this.pm_num){
  //       this.showtodaylist.pm[down_num].isorder=true;
  //     }



  //    // console.log(someArray[i]); // 1, "string", false
  //   ​
  //   }
}

}
