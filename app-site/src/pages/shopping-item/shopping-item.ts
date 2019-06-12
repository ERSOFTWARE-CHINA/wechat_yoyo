import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

import { CommodityService } from './service';
import { BusService } from '../../share/bus.service';


@IonicPage(
  {
    name: 'ShoppingItemPage',
    segment: 'shopping-item'
  }
)
@Component({
  selector: 'shopping-item',
  templateUrl: 'shopping-item.html',
})
export class ShoppingItemPage implements OnInit {

  data: any = []
  q: any = {}

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    private srv: CommodityService,
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
    this.navCtrl.push("ShoppingItemDetailPage")
  }

}
