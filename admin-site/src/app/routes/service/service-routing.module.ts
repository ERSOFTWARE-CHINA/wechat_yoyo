import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ServiceComponent } from './service.component';
import { ServiceListComponent } from './list/list.component';
import { ServiceFormComponent } from './form/form.component';

const routes: Routes = [
  {
    path: '',
    component: ServiceComponent,
    children: [
      { path: '', redirectTo: 'page', pathMatch: 'full' },
      { path: 'page', component: ServiceListComponent },
      { path: 'form', component: ServiceFormComponent },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ServiceRoutingModule {}
