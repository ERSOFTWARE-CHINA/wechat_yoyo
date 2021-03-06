import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AlertController } from 'ionic-angular';
/**
 * Generated class for the OrderMePage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-order-me',
  templateUrl: 'order-me.html',
})
export class OrderMePage {
  orderlistunuse = [
    {
      "thumbimg":"assets/img/thumbnail-totoro.png",
      "orderpersonname": "张三",
      "shopname": "店一",
      "ordertime": "1563715306644",
      "tips": "备注要求",    
      "show": false, 
    },
    {
      "thumbimg":"assets/img/thumbnail-totoro.png",
      "orderpersonname": "李四",
      "shopname": "店一",
      "ordertime": "1563715906644",
      "tips": "备注要求",   
      "show": false, 
    }
  ];




  constructor(public navCtrl: NavController, public navParams: NavParams,public alertCtrl: AlertController) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderMePage');
  }

  showAlert(ordertime) {
    console.log(parseInt(ordertime));
   
   // console.log((new Date(ordertime/1000)));
  // console.log((new Date(parseInt(ordertime))).toDateString());
  // console.log((new Date(1563715306644)).toDateString());
    const alert = this.alertCtrl.create({
      title: '取消确认',
      subTitle: ('您确认取消'.concat(new Date(parseInt(ordertime)).toDateString())).concat('的预约？'),
      buttons: ['确定']
    });
    alert.present();
  }


}
