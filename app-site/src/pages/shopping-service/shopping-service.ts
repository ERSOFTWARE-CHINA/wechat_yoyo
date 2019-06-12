import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';


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
export class ShoppingServicePage {

  constructor(public navCtrl: NavController, public navParams: NavParams) {

  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

}
