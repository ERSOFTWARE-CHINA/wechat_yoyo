import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams, ActionSheet } from 'ionic-angular';

/**
 * Generated class for the OrderPresonPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

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

  constructor(public navCtrl: NavController, public navParams: NavParams) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

}
