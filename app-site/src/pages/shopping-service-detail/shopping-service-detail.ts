import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AlertController } from 'ionic-angular';

import { ServiceDetailService } from './service';
import { BusService } from '../../share/bus.service';


@IonicPage(
  {
    name: 'ShoppingServiceDetailPage',
    segment: 'shopping-service-detail'
  }
)
@Component({
  selector: 'shopping-service-detail',
  templateUrl: 'shopping-service-detail.html',
})
export class ShoppingServiceDetailPage implements OnInit {

  data: any = {}
  beforeBuy = true;
  number = 1; //购买数量
  total = 0;  //购买总价格
  remainder = 0; //账户余额

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    public alertCtrl: AlertController,
    private srv: ServiceDetailService,
    private bus: BusService) {

  }

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.data = this.bus.entity
    console.log(this.data)
  }


  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

  buy(){
    this.beforeBuy = false;
  }

  add(){
   this.number = this.number + 1;
  }

  minus(){
    if (this.number >= 2) this.number = this.number - 1;
  }

  submit(){
    this.total = this.data.current_price * this.number;
    this.checkAccount();
    let v = {service_order: {amount: this.number, times: this.number * this.data.times, user: {wechat_openid: localStorage.getItem("openid")}, service: {id: this.data.id}},
      pay_type: "优悠账户",
      amount: this.number
    }
    this.srv.buy(v).then(resp => {if ((resp.result)=="ok") {this.showOK()} else{this.showError()} })
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
    this.navCtrl.push('ShoppingServicePage');
  }

  //检查优悠账户余额是否足够
  checkAccount(){
    this.srv.getAccount().then(resp => {if (resp.data.remainder >= this.total) {
      console.log("账户支付")
    }else console.log("微信支付") });
  }



}
