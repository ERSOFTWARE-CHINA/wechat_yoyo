import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { OrderMePage } from './order-me';

@NgModule({
  declarations: [
    OrderMePage,
  ],
  imports: [
    IonicPageModule.forChild(OrderMePage),
  ],
})
export class OrderMePageModule {}
