import { NgModule } from '@angular/core';
import { SharedModule } from '@shared';

import { ShowAppointmentComponent } from './showAppointment.component';
import { ShowAppointmentService } from './showAppointment.service';
import { ShowAppointmentRoutingModule } from './showAppointment-routing.module';

@NgModule({
  imports: [SharedModule, ShowAppointmentRoutingModule],
  declarations: [ShowAppointmentComponent],
  providers: [ShowAppointmentService],
})
export class ShowAppointmentModule {}
