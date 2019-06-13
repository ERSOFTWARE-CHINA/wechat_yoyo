import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingItemDetailPage } from './shopping-item-detail';
//import { OrderListPage } from '../order-list/order-list'
import { CommodityDetailService} from './service';

@NgModule({
  declarations: [
    ShoppingItemDetailPage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingItemDetailPage),
   // OrderListPage,
  ],
  providers: [
    CommodityDetailService
  ]
  //entryComponents: [OrderListPage,]
})
export class ShoppingItemDetailPageModule {}
