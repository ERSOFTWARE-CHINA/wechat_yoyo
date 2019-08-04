import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ShowAppointmentComponent } from './showAppointment.component';

const routes: Routes = [
  {
    path: '',
    component: ShowAppointmentComponent,
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ShowAppointmentRoutingModule {}
