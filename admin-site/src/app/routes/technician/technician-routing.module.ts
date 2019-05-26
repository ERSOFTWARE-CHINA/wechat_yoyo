import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { TechnicianComponent } from './technician.component';
import { TechnicianListComponent } from './list/list.component';
import { TechnicianFormComponent } from './form/form.component';

const routes: Routes = [
  {
    path: '',
    component: TechnicianComponent,
    children: [
      { path: '', redirectTo: 'page', pathMatch: 'full' },
      { path: 'page', component: TechnicianListComponent },
      { path: 'form', component: TechnicianFormComponent },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class TechnicianRoutingModule {}
