import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { OrderPresonPage } from './order-preson';
//import { OrderListPage } from '../order-list/order-list'

@NgModule({
  declarations: [
    OrderPresonPage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(OrderPresonPage),
   // OrderListPage,
  ],
  //entryComponents: [OrderListPage,]
})
export class OrderPresonPageModule {}
