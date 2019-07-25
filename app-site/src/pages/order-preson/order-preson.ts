import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';


import { TechnicianService } from './service';
import { BusService } from '../../share/bus.service';


@IonicPage(
  {
    name: 'OrderPresonPage',
    segment: 'order-preson'
  }
)
@Component({
  selector: 'page-order-preson',
  templateUrl: 'order-preson.html',
})
export class OrderPresonPage {

  data: any = []
  q: any = {}

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams,
    private srv: TechnicianService,
    private bus: BusService) {
  }

  ionViewDidEnter() {
    this.getData();
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

  book(i) {
    this.bus.serviceToBeBook = i
    this.navCtrl.push("OrderListPage")
  }

}
