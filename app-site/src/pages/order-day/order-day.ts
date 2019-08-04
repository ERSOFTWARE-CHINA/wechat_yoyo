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
    else this.srv.create(this.getReqParam()).then(resp => 
      {
        if (resp["data"]) {
          this.showOK();
        } else this.showError();
      } 
    )
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
      service: {id: this.bus.serviceToBeBook},
      technician: {id: this.bus.technicianToBeBook.id},
      user: {"openid": localStorage.getItem("openid")}
    }
  }

  dateChanged() {
    console.log("date changed")
    this.getAppointmentData()
  }

  ionViewDidLoad() {
    // console.log('ionViewDidLoad OrderDayPage');
  }

  ionViewDidEnter() {
    this.getAppointmentData()
  }

  showError() {
    const alert = this.alertCtrl.create({
      title: '预定失败',
      subTitle: '抱歉，请稍后再试',
      // subTitle: localStorage.getItem("code"),
      buttons: ['OK']
    });
    alert.present();
    
  }

  showOK() {
    const alert = this.alertCtrl.create({
      title: '预定成功',
      subTitle: '预定成功，可前往 我的预约 查看确认！',
      buttons: ['OK']
    });
    alert.present();
    this.navCtrl.push('OrderPresonPage');
  }

}
