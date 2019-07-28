import { Component, OnInit  } from '@angular/core';
import { IonicPage, NavController, NavParams,ModalController,AlertController } from 'ionic-angular';
//引入自定义组件
import { OrderListSelectComponent } from '../../components/order-list-select/order-list-select'
import { UserServiceService} from './service';
import { BusService } from '../../share/bus.service';


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
export class OrderListPage implements OnInit  {

  data: any[];
  q: any;
  selected: any = null;

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams, 
    public alertCtrl: AlertController,
    private srv: UserServiceService,
    private bus: BusService) {

  }
  

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.srv.list(this.q)
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
    console.log('ionViewDidLoad OrderListPage');
  }

  goDay(){
    if (this.selected  != null) {
      this.bus.serviceToBeBook = this.selected;
      console.log(this.bus.serviceToBeBook)
      this.navCtrl.push('OrderDayPage');
    } else this.doPrompt();
  }

  optionsFn() {
    console.log(this.selected)
  }

  doPrompt() {
    let prompt = this.alertCtrl.create({
      title: '提示',
      message: "您当前未选择任何服务！",
      
      buttons: [
        {
          text: '返回',
          handler: data => {
            console.log('Cancel clicked');
          }
        }
      ]
    });
    prompt.present();
  }

}
