import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AlertController } from 'ionic-angular';

import { CommodityDetailService } from './service';
import { BusService } from '../../share/bus.service';


@IonicPage(
  {
    name: 'ShoppingItemDetailPage',
    segment: 'shopping-item-detail'
  }
)
@Component({
  selector: 'shopping-item-detail',
  templateUrl: 'shopping-item-detail.html',
})
export class ShoppingItemDetailPage implements OnInit {

  data: any = {}
  beforeBuy = true;
  number = 1;

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    public alertCtrl: AlertController,
    private srv: CommodityDetailService,
    private bus: BusService) {}
  
  doPrompt() {
    let prompt = this.alertCtrl.create({
      title: '提示',
      message: "购买之前需要将信息填写完整",
      
      buttons: [
        {
          text: '暂时不要',
          handler: data => {
            console.log('Cancel clicked');
          }
        },
        {
          text: '现在填写',
          handler: data => {
            this.navCtrl.push('SettingsPage');
          }
        }
      ]
    });
    prompt.present();
  }

  doPayPrompt(data) {
    // let v = {order: {amount: this.number, user: {wechat_openid: localStorage.getItem("openid")}, commodity: {id: this.data.id}}}
      
      let amount = this.data.current_price * this.number;
      //默认账户支付
      let pay_type = 1;
      //金额不够则使用微信支付
      if (parseFloat(localStorage.getItem("remainder")) < amount) pay_type = 0;
      let params = {id: data.id, order: data, pay_type: pay_type}
      let prompt = this.alertCtrl.create({
        title: '提示',
        message: "您选择了："+ data.commodity + "* "+ data.amount + "共计：" + (this.data.current_price * this.number) + " 元,确定要支付吗？",
        
        buttons: [
          {
            text: '暂时不要',
            handler: data => {
              console.log('Cancel clicked');
              this.navCtrl.push('ShoppingItemPage')
            }
          },
          {
            text: '现在支付',
            handler: data => {
              // this.navCtrl.push('SettingsPage');
              if (pay_type == 1) this.srv.pay(params).then( resp=> this.navCtrl.push('ShoppingItemPage'));
              if (pay_type ==0) console.log("微信支付！")
            }
          }
        ]
      });
      prompt.present();
    }
  

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.data = this.bus.entity
  }


  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

  buy(){
    // localStorage.removeItem("address");
    // localStorage.removeItem("mobile");
    if (localStorage.getItem("address") && localStorage.getItem("mobile")) { this.beforeBuy = false }
    else this.doPrompt()
  }

  add(){
    if (this.number <= this.data.stock) this.number = this.number + 1;
  }

  minus(){
    if (this.number >= 2) this.number = this.number - 1;
  }

  submit(){
    let v = {order: {amount: this.number, user: {wechat_openid: localStorage.getItem("openid")}, commodity: {id: this.data.id}}}
    this.srv.buy(v).then(resp => {if (resp.data) {console.log(resp.data); this.doPayPrompt(resp.data)} else{this.showError()} })
  }

  showError() {
    const alert = this.alertCtrl.create({
      title: '购买失败',
      subTitle: '抱歉，请稍后再试',
      // subTitle: localStorage.getItem("code"),
      buttons: ['OK']
    });
    alert.present();
    
  }

  showOK() {
    const alert = this.alertCtrl.create({
      title: '购买成功',
      subTitle: '购买成功！',
      buttons: ['OK']
    });
    alert.present();
    this.navCtrl.push('ShoppingItemPage');
  }
}
