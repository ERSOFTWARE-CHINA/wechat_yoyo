import { Component, OnInit } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

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

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    private srv: CommodityDetailService,
    private bus: BusService) {

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

}
