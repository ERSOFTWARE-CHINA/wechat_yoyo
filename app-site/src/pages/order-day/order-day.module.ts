import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { OrderDayPage } from './order-day';
import { AppointmentService } from './service';

@NgModule({
  declarations: [
    OrderDayPage,
  ],
  imports: [
    IonicPageModule.forChild(OrderDayPage),
  ],
  providers: [ AppointmentService ]
})
export class OrderDayPageModule {}
