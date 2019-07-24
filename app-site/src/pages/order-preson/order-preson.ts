import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';


import { TechnicianService } from './service';
import { BusService } from '../../share/bus.service';

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
//考虑以后多门面情况，在此考虑反馈多重数据。
// show_shopandpersonlist=[
//   {
//     shopid:'yoyo_no1',
//     shopname:'门面店一',
//     personlist:[
//       {
//         "name": "技师姓名A",
//         "avatar": "assets/img/speakers/bear.jpg",
//         "occupation": "职业",
//         "characteristic": "性格特点",
//         "orders": "预约数100",
//         "works": "作品数",    
//         "rank": "好评率",
//       },
//       {
//         "name": "技师姓名B",
//         "avatar": "assets/img/speakers/bear.jpg",
//         "occupation": "职业",
//         "characteristic": "性格特点",
//         "orders": "预约数100",
//         "works": "作品数",    
//         "rank": "好评率",
//       }
//     ]
//   },
//   {    
//     shopid:'yoyo_no2',
//     shopname:'门面店二',
//     personlist:[
//       {
//         "name": "技师姓名c",
//         "avatar": "assets/img/speakers/bear.jpg",
//         "occupation": "职业",
//         "characteristic": "性格特点",
//         "orders": "预约数100",
//         "works": "作品数",    
//         "rank": "好评率",
//       },
//       {
//         "name": "技师姓名d",
//         "avatar": "assets/img/speakers/bear.jpg",
//         "occupation": "职业",
//         "characteristic": "性格特点",
//         "orders": "预约数100",
//         "works": "作品数",    
//         "rank": "好评率",
//       }
//     ]    
//   }
// ];

//明确门面店数量
// shopNum=this.show_shopandpersonlist.length;


//   //测试 ：定义一个personID参数
//   public personID:number;
//   tempid=0;
// //初始定值
//   pet: string = "yoyo_no1";
// //先定义一个组件类
// OrderListPage


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

  // //goorderlist利用代码后台处理  push后页面为什么是字符串而不是一个组件但是页面组件却可以是组件，懒加载模式下
  // golist(){
  //   this.navCtrl.push('OrderListPage',{
  //     personID:'1'
  //   });
  // }

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderPresonPage');
  }

}
