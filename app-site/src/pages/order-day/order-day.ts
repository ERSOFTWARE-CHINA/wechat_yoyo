import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams, AlertController } from 'ionic-angular';
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
  selectedDate: string = null;
  minDate: string;
  maxDate: string;

  selectedTime: string = null;

  times = [
    { value: "09:00", color: "primary", enabled: false }, { value: "09:30", color: "primary", enabled: false }, { value: "10:00", color: "primary", enabled: false },
    { value: "10:30", color: "primary", enabled: false }, { value: "11:00", color: "primary", enabled: false }, { value: "11:30", color: "primary", enabled: false },
    { value: "12:00", color: "primary", enabled: false }, { value: "12:30", color: "primary", enabled: false }, { value: "13:00", color: "primary", enabled: false },
    { value: "13:30", color: "primary", enabled: false }, { value: "14:00", color: "primary", enabled: false }, { value: "14:30", color: "primary", enabled: false },
    { value: "15:00", color: "primary", enabled: false }, { value: "15:30", color: "primary", enabled: false }, { value: "16:00", color: "primary", enabled: false },
    { value: "16:30", color: "primary", enabled: false }, { value: "17:00", color: "primary", enabled: false }, { value: "17:30", color: "primary", enabled: false },
    { value: "18:00", color: "primary", enabled: false }, { value: "18:30", color: "primary", enabled: false }, { value: "19:00", color: "primary", enabled: false },
    { value: "19:30", color: "primary", enabled: false }, { value: "20:00", color: "primary", enabled: false }, { value: "20:30", color: "primary", enabled: false }
  ]
  
  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams,
    public alertCtrl: AlertController,
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
    this.srv.list(this.selectedDate, this.bus.serviceToBeBook.id, this.bus.technicianToBeBook.id).then(resp => {console.log(resp);this.setEnabled(resp["data"]);})
  }

  setEnabled(data) {
    for (let i in this.times) {
      this.times[i]["enabled"] = true
      for (let j in data) {
        if (this.times[i]["value"] == data[j]["time"]) {
          this.times[i]["enabled"] = false
        }
      }
    }
  }

  clickOne(e) {
    for (let i in this.times) {
      if (this.times[i]["value"] == e["value"]) {
        this.times[i]["color"] = "secondary";
        this.selectedTime = e["value"];
      } else this.times[i]["color"] = "primary";
    }

  }

  submit() {
    if (this.selectedDate == null) {this.doPrompt("请选择日期！")}
    else if (this.selectedTime == null) {this.doPrompt("请选择时间段！")}
    else { this.srv.create(this.getReqParam()).then(resp => console.log(resp)) } 
  }

  doPrompt(m) {
    let prompt = this.alertCtrl.create({
      title: '提示',
      message: m,
      
      buttons: [
        {
          text: '返回',
          handler: data => {
            console.log('Cancel clicked');
          }
        }
      ]
    });
    prompt.present();
  }

  getReqParam() {
    return {
      date: this.selectedDate, 
      time: this.selectedTime, 
      service: {id: this.bus.serviceToBeBook.id},
      technician: {id: this.bus.technicianToBeBook.id},
      user: {"openid": localStorage.getItem("openid")}
    }
  }

  dateChanged(v) {
    this.getAppointmentData()
    console.log(v)
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderDayPage');
  }

  ionViewDidEnter() {
    this.getAppointmentData()
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
