import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingVipPage } from './shopping-vip';
//import { OrderListPage } from '../order-list/order-list'
import { VipService} from './service';

@NgModule({
  declarations: [
    ShoppingVipPage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingVipPage),
   // OrderListPage,
  ],
  providers: [
    VipService
  ]
  //entryComponents: [OrderListPage,]
})
export class ShoppingVipPageModule {}
