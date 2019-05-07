import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { OrderDayPage } from './order-day';

@NgModule({
  declarations: [
    OrderDayPage,
  ],
  imports: [
    IonicPageModule.forChild(OrderDayPage),
  ],
})
export class OrderDayPageModule {}
