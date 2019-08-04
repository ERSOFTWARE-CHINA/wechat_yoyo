import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared';

import { AppointmentRoutingModule } from './appointment-routing.module';

import { AppointmentComponent } from './appointment.component';
import { AppointmentListComponent } from './list/list.component';
import { AppointmentService } from './service/appointment.service';

@NgModule({
  imports: [SharedModule, AppointmentRoutingModule],
  declarations: [AppointmentComponent, AppointmentListComponent],
  providers: [
    AppointmentService,
    // ConfirmationService
  ],
})
export class AppointmentModule {}
