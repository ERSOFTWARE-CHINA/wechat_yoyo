import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared';

import { CommodityOrderRoutingModule } from './commodityOrder-routing.module';

import { CommodityOrderComponent } from './commodityOrder.component';
import { CommodityOrderListComponent } from './list/list.component';
import { CommodityOrderService } from './service/commodityOrder.service';

@NgModule({
  imports: [SharedModule, CommodityOrderRoutingModule],
  declarations: [CommodityOrderComponent, CommodityOrderListComponent],
  providers: [
    CommodityOrderService,
    // ConfirmationService
  ],
})
export class CommodityOrderModule {}
