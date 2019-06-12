import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingItemPage } from './shopping-item';
//import { OrderListPage } from '../order-list/order-list'
import { CommodityService} from './service';

@NgModule({
  declarations: [
    ShoppingItemPage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingItemPage),
   // OrderListPage,
  ],
  providers: [
    CommodityService
  ]
  //entryComponents: [OrderListPage,]
})
export class ShoppingItemPageModule {}
