import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CommodityComponent } from './commodity.component';
import { CommodityListComponent } from './list/list.component';
import { CommodityFormComponent } from './form/form.component';

const routes: Routes = [
  {
    path: '',
    component: CommodityComponent,
    children: [
      { path: '', redirectTo: 'page', pathMatch: 'full' },
      { path: 'page', component: CommodityListComponent },
      { path: 'form', component: CommodityFormComponent },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CommodityRoutingModule {}
