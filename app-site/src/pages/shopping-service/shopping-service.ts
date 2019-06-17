import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

import { ShoppingSrvService } from './service';
import { BusService } from '../../share/bus.service';


@IonicPage(
  {
    name: 'ShoppingServicePage',
    segment: 'shopping-service'
  }
)
@Component({
  selector: 'shopping-service',
  templateUrl: 'shopping-service.html',
})
export class ShoppingServicePage implements OnInit {

  data: any = []
  q: any = {}

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    private srv: ShoppingSrvService,
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

  goDetail(i){
    this.bus.entity = i
    this.navCtrl.push("ShoppingServiceDetailPage")
  }

}
