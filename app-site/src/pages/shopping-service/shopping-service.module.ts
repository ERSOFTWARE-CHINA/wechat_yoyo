import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingServicePage } from './shopping-service';
//import { OrderListPage } from '../order-list/order-list'
import { ShoppingSrvService} from './service';

@NgModule({
  declarations: [
    ShoppingServicePage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingServicePage),
   // OrderListPage,
  ],
  providers: [
    ShoppingSrvService
  ]
  //entryComponents: [OrderListPage,]
})
export class ShoppingServicePageModule {}
