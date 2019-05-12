import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

//引入预定列表页面
//import { OrderListPage } from '../order-list/order-list'

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

//初始定值
  pet: string = "puppies";
//先定义一个组件类
OrderListPage
//先定义一个数组
personitems = [
  {
    "name": "技师姓名A",
    "avatar": "assets/img/speakers/bear.jpg",
    "occupation": "职业",
    "characteristic": "性格特点",
    "orders": "预约数100",
    "works": "作品数",    
    "rank": "好评率",
  },
  {
    "name": "技师姓名B",
    "avatar": "assets/img/speakers/bear.jpg",
    "occupation": "职业",
    "characteristic": "性格特点",
    "orders": "预约数100",
    "works": "作品数",    
    "rank": "好评率",
  }
];


  constructor(public navCtrl: NavController, public navParams: NavParams) {
    //this.OrderListPage = OrderListPage;//网页组件跳转

  }

  //goorderlist利用代码后台处理  push后页面为什么是字符串而不是一个组件但是页面组件却可以是组件，懒加载模式下
  golist(){
    this.navCtrl.push('OrderListPage');
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

}
