import { Component  } from '@angular/core';
import { IonicPage, NavController, NavParams,ModalController,AlertController } from 'ionic-angular';
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

  music: string;
  notifications:string;
//先定义一个数组
listitems = [
  {
    "name": "产后修复项目",
    "name1": "assets/img/speakers/bear.jpg",
    "name2": "职业",
    "name3": "性格特点",
    "name4": "预约数100",   
  },
  {
    "name": "婴儿游泳SPA",
    "name1": "assets/img/speakers/bear.jpg",
    "name2": "职业",
    "name3": "性格特点",
    "name4": "预约数100",   
  }
];
//
checktext: any;

musicAlertOpts: { title: string, subTitle: string, buttons:any };

  constructor(public alertCtrl: AlertController,public navCtrl: NavController, public navParams: NavParams,public modalController: ModalController) {  
    this.musicAlertOpts = {
      title: '1994 Music',
      subTitle: 'Select your favorite',
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel',
          handler: () => {
            console.log('Cancel clicked');
          }
        },
        {
          text: 'Buy',
          handler: () => {
            console.log('Buy clicked');
          }
        }
      ]
};
  }


  async presentModal() {
    /*const modal = await this.modalController.create({
      showBackdrop:true,
      component: 'OrderListSelectComponent',
      componentProps: { value: 123 }
    });*/
    const modal = await this.modalController.create(OrderListSelectComponent);

    return await modal.present();
  }
  
//选择框
  showCheckbox() {
    let alert = this.alertCtrl.create();
    alert.setTitle('请选择技师');

    alert.addInput({
      type: 'checkbox',
      label: '选择了1',
      value: '选择了1',
      //checked: true //默认选择
    });

    alert.addInput({
      type: 'checkbox',
      label: '选择了2',
      value: '选择了2'
    });

  //  alert.addButton('Cancel');
    alert.addButton({
      text: '确定',
      handler: data => {
        console.log('Checkbox data:', data);
        //this.testCheckboxOpen = false;
       this.checktext=data;
      }
    });
    alert.present();
  }


  changetemp(){
    this.navCtrl.push('OrderDayPage');
  }



  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderListPage');
  }


  //push后页面为什么是字符串而不是一个组件但是页面组件却可以是组件，懒加载模式下
  goDay(){
    this.navCtrl.push('OrderDayPage');
  }

}
