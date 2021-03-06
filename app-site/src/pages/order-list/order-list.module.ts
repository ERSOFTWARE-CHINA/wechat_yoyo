import { NgModule } from '@angular/core';
import { IonicPageModule,IonicModule } from 'ionic-angular';
import { OrderListPage } from './order-list';
//引入自定义组件
import { ComponentsModule  } from '../../components/components.module'
import { UserServiceService} from './service';

@NgModule({
  declarations: [
    OrderListPage,    
  ],  
  imports: [
    IonicPageModule.forChild(OrderListPage), ComponentsModule ,IonicModule  
  ],
  providers: [
    UserServiceService
  ]
 
})
export class OrderListPageModule {}
