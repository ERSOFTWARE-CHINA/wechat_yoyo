import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ShoppingServiceDetailPage } from './shopping-service-detail';
//import { OrderListPage } from '../order-list/order-list'
import { ServiceDetailService} from './service';

@NgModule({
  declarations: [
    ShoppingServiceDetailPage,
   // OrderListPage
  ],
  imports: [
    IonicPageModule.forChild(ShoppingServiceDetailPage),
   // OrderListPage,
  ],
  providers: [
    ServiceDetailService
  ]
  //entryComponents: [OrderListPage,]
})
export class ShoppingServiceDetailPageModule {}
