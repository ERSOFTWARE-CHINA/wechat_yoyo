import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { OrderShowMePage } from './order-show-me';

@NgModule({
  declarations: [
    OrderShowMePage,
  ],
  imports: [
    IonicPageModule.forChild(OrderShowMePage),
  ],
})
export class OrderShowMePageModule {}
