import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';


@IonicPage(
  {
    name: 'ShoppingCenterPage',
    segment: 'shopping-center'
  }
)
@Component({
  selector: 'shopping-center',
  templateUrl: 'shopping-center.html',
})
export class ShoppingCenterPage {

  constructor(public navCtrl: NavController, public navParams: NavParams) {

  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

  goItem(){
    this.navCtrl.push('ShoppingItemPage');
  }

  goService(){
    this.navCtrl.push('ShoppingServicePage');
  }

}
