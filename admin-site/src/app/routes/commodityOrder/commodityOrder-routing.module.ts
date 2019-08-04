import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { CommodityOrderComponent } from './commodityOrder.component';
import { CommodityOrderListComponent } from './list/list.component';

const routes: Routes = [
  {
    path: '',
    component: CommodityOrderComponent,
    children: [
      { path: '', redirectTo: 'page', pathMatch: 'full' },
      { path: 'page', component: CommodityOrderListComponent },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CommodityOrderRoutingModule {}
