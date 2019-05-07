import { Component  } from '@angular/core';
import { IonicPage, NavController, NavParams,ModalController } from 'ionic-angular';
//引入自定义组件
import { OrderListSelectComponent } from '../../components/order-list-select/order-list-select'
/**
 * Generated class for the OrderListPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage(
  {
    name: 'OrderListPage',
    segment: 'order-list'
  }

)
@Component({
  selector: 'page-order-list',
  templateUrl: 'order-list.html',
})
export class OrderListPage {

  constructor(public navCtrl: NavController, public navParams: NavParams,public modalController: ModalController) {  
  }

  async presentModal() {
    const modal = await this.modalController.create({
      showBackdrop:true,
      component: OrderListSelectComponent,
      componentProps: { value: 123 }
    });
    return await modal.present();
  }
  
  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderListPage');
  }

}
