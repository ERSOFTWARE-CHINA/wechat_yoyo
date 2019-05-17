import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { OrderEnsurePage } from './order-ensure';

@NgModule({
  declarations: [
    OrderEnsurePage,
  ],
  imports: [
    IonicPageModule.forChild(OrderEnsurePage),
  ],
})
export class OrderEnsurePageModule {}
