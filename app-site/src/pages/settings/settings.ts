import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AlertController } from 'ionic-angular';
import { Platform } from 'ionic-angular';

import { Settings } from '../../providers';
import { SettingsService } from './service';
import { deleteAttr } from '../../utils/format';
 
/**
 * The Settings page is a simple form that syncs with a Settings provider
 * to enable the user to customize settings for the app.
 *
 */
@IonicPage(
  {
    name: 'SettingsPage',
    segment: 'page-settings'
  }
)
@Component({
  selector: 'page-settings',
  templateUrl: 'settings.html'
})
export class SettingsPage implements OnInit {
  content: string = "account";
  accounts: any = {card_name: "", remainder: null};
  orders: any[] = [];
  appointments: any[] = [];
  records: any[] =[];

  address: string;
  mobile: string;
  fullName: string;

  constructor(public navCtrl: NavController,
    public settings: Settings,
    public formBuilder: FormBuilder,
    public navParams: NavParams,
    private alertCtrl: AlertController,
    private srv: SettingsService,
    public translate: TranslateService) {
  }

  ngOnInit(){
    this.address = localStorage.getItem("address");
    this.mobile = localStorage.getItem("mobile");
    this.fullName = localStorage.getItem("fullName");
    this.getData();
  }

  doPrompt() {
    let prompt = this.alertCtrl.create({
      title: '填写信息',
      message: "务必填写真实信息",
      inputs: [
        {
          name: 'full_name',
          value: this.fullName,
          placeholder: '姓名'
        },
        {
          name: 'mobile',
          value: this.mobile,
          placeholder: '手机号'
        },
        {
          name: 'address',
          value: this.address,
          placeholder: '地址'
        },
        
      ],
      buttons: [
        {
          text: '取消',
          handler: data => {
            console.log('Cancel clicked');
          }
        },
        {
          text: '提交',
          handler: data => {
            this.saveInfo(data);
            // this.navCtrl.push('SettingsPage');
          }
        }
      ]
    });
    prompt.present();
  }

  ionViewDidEnter(){
    this.getData();
  }

  getData(){
    this.getAccountData();
    // this.getAppointmentData();
    // this.getOrderData();
    // this.getRecordData();
  }

  getAccountData(){
    this.srv.getAccounts().then(resp => this.accounts = resp.data);
  }

  getOrderData(){
    this.srv.getOrders().then(resp => this.orders = resp.data).then(_=>console.log(this.orders));

  }

  getAppointmentData(){
    this.srv.getAppointments().then(resp => this.appointments = resp.data).then(_=>console.log(this.appointments));
  }

  getRecordData(){
    this.srv.getRecords().then(resp => this.records = resp.data).then(_=>console.log(this.records));
  }

  modifyInfo(){
    this.doPrompt();
  }

  saveInfo(data){
    this.srv.setInfo(deleteAttr(data)).then(resp=> this.resetUser(resp.data));
  }

  resetUser(u){
    if ((u.mobile)&&(u.mobile!='')) { localStorage.setItem("mobile", u.mobile); this.mobile = u.mobile; } 
    if ((u.full_name)&&(u.full_name!='')) { localStorage.setItem("fullName", u.full_name); this.fullName = u.full_name; } 
    if ((u.address)&&(u.address!='')) { localStorage.setItem("address", u.address); this.address = u.address; } 
  }

}
