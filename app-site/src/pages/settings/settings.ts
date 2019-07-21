import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AlertController } from 'ionic-angular';
// import { Platform } from 'ionic-angular';

import { Settings } from '../../providers';
import { SettingsService } from './service';
import { deleteAttr } from '../../utils/format';
import { WechatService } from '../login/auth.service';
 
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
  // accounts: any = {card_name: "", remainder: null};
  orders: any[] = [];
  appointments: any[] = [];
  records: any[] =[];

  // address: string;
  // mobile: string;
  // fullName: string;
  // remainder: any;
  // card_name: string;

  constructor(public navCtrl: NavController,
    public settings: Settings,
    public formBuilder: FormBuilder,
    public navParams: NavParams,
    private alertCtrl: AlertController,
    private srv: SettingsService,
    public translate: TranslateService,
    private wcSrv: WechatService) {
  }

  ngOnInit(){
    // this.address = localStorage.getItem("address");
    // this.mobile = localStorage.getItem("mobile");
    // this.fullName = localStorage.getItem("fullName");
    this.getData();
  }

  doPrompt() {
    let prompt = this.alertCtrl.create({
      title: '填写信息',
      message: "务必填写真实信息",
      inputs: [
        {
          name: 'full_name',
          value: this.full_name,
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
    this.getAppointmentData();
    this.getOrderData();
    this.getRecordData();
  }

  get full_name(): any {
    return localStorage.getItem('full_name');
  }

  get mobile(): any {
    return localStorage.getItem('mobile');
  }

  get address(): any {
    return localStorage.getItem('address');
  }

  get card_name(): any {
    return localStorage.getItem('card_name');
  }

  get remainder(): any {
    return localStorage.getItem('remainder');
  }

  getAccountData(){
    this.wcSrv.auto_login(localStorage.getItem("openid"));
  }

  getOrderData(){
    this.srv.getOrders().then(resp => this.orders = resp.data).then(_=>console.log(this.orders));

  }

  getAppointmentData(){
    this.srv.getAppointments().then(resp => this.appointments = resp.data).then(_=>console.log(this.appointments));
  }

  getRecordData(){
    this.srv.getRecords().then(resp => this.records = resp.data).then(_=>{console.log("消费记录"); console.log(this.records)});
  }

  modifyInfo(){
    this.doPrompt();
  }

  saveInfo(data){
    this.srv.setInfo(deleteAttr(data)).then(resp=> this.resetUser(resp.data));
  }

  resetUser(u){
    if ((u.mobile)&&(u.mobile!='')) { localStorage.setItem("mobile", u.mobile); } 
    if ((u.full_name)&&(u.full_name!='')) { localStorage.setItem("full_name", u.full_name); } 
    if ((u.address)&&(u.address!='')) { localStorage.setItem("address", u.address); } 
  }

  doPayPrompt(i) {
    // let v = {order: {amount: this.number, user: {wechat_openid: localStorage.getItem("openid")}, commodity: {id: this.data.id}}}
      
      let value = i.price * i.amount;
      //默认账户支付
      let pay_type = 1;
      //金额不够则使用微信支付
      if (parseFloat(localStorage.getItem("remainder")) < value) pay_type = 0;
      let params = {id: i.id, order: i, pay_type: pay_type}
      let prompt = this.alertCtrl.create({
        title: '提示',
        message: "您选择了："+ i.commodity + "* "+ i.amount + " 件。 "+ "共计：" + value + " 元,确定要支付吗？",
        
        buttons: [
          {
            text: '暂时不要',
            handler: data => {
              console.log('Cancel clicked');
            }
          },
          {
            text: '现在支付',
            handler: data => {
              // this.navCtrl.push('SettingsPage');
              if (pay_type == 1) this.srv.pay(params).then( resp=> this.getData());
              if (pay_type ==0) console.log("微信支付！")
            }
          }
        ]
      });
      prompt.present();
  }

  pay(i) {
    // console.log(i)
    // let params = {id: i.id, order: i, pay_type: pay_type}
    // this.srv.pay(i)
    this.doPayPrompt(i)
  }

}
