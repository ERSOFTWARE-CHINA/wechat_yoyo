import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingServicePage } from './shopping-service';
//import { OrderListPage } from '../order-list/order-list'

@NgModule({
  declarations: [
    ShoppingServicePage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingServicePage),
   // OrderListPage,
  ],
  //entryComponents: [OrderListPage,]
})
export class ShoppingServicePageModule {}
