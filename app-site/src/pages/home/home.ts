import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { Products } from '../../providers';
/**
 * Generated class for the HomePage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage(
  {
  name: 'HomePage',
  segment: 'home-path'
}
)
@Component({
  selector: 'page-home',
  templateUrl: 'home.html',
})
export class HomePage {   
  products: any;

  //定义登录接口的数据
  account: { model_name: string, app_key: string,logic: string, where:  string, page:  string, perpage:  string } = {
    model_name : 'products',
    app_key:   '5B204A1457C6003A569F6A5952306A8C',    
    logic : 'and',
    where : '[["id", "<", "10"]]',
    page : '1',
    perpage: '10'
  };

  constructor( public productMode: Products, public navCtrl: NavController, public navParams: NavParams) {
    this.getProducts();
  }  
  //获取首页推荐列表
  getProducts() {
    this.productMode.getList(this.account).subscribe((resp) => {
      console.debug(resp);
      this.products = this.productMode._list; //返回值后product服务就可以获取相应的值
    });

   //作为例子参考
    /*this.api.httpGet(AppGlobal.API.getProducts, this.params, rs => {
      console.debug(rs);
      this.products = rs.data;
    })*/
  }
  //商品详情
  goDetails(item) {
    console.debug('go details...')
  }
  




  }



