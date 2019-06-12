import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingCenterPage } from './shopping-center';

@NgModule({
  declarations: [
    ShoppingCenterPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingCenterPage),
   // OrderListPage,
  ],
  //entryComponents: [OrderListPage,]
})
export class ShoppingCenterPageModule {}
