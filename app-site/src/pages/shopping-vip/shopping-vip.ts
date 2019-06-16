import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AlertController } from 'ionic-angular';

import { VipService } from './service';
import { BusService } from '../../share/bus.service';


@IonicPage(
  {
    name: 'ShoppingVipPage',
    segment: 'shopping-vip'
  }
)
@Component({
  selector: 'shopping-vip',
  templateUrl: 'shopping-vip.html',
})
export class ShoppingVipPage implements OnInit {

  data: any = []
  q: any = {}

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    private srv: VipService,
    private alertCtrl: AlertController,
    private bus: BusService) {

  }

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.srv.listOnePage(this.q)
      .then(resp => {
        if (resp.error) {
          console.log(resp.error)
        } else {
          this.data = resp.data; 
          console.log(this.data);
        }
      })
      .catch((error) => {error => console.log(error)})
  }


  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

  buy(i){
    this.srv.buy(i).then(resp => {if (resp["data"]) {this.showOK()} else{this.showError()} });
  }

  showError() {
    const alert = this.alertCtrl.create({
      title: '充值失败',
      subTitle: '抱歉，请稍后再试',
      // subTitle: localStorage.getItem("code"),
      buttons: ['OK']
    });
    alert.present();
    
  }

  showOK() {
    const alert = this.alertCtrl.create({
      title: '充值成功',
      subTitle: '充值成功！',
      buttons: ['OK']
    });
    alert.present();
    this.navCtrl.push('ShoppingCenterPage');
  }

}
