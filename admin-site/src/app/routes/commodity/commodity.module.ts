import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared/shared.module';

import { CommodityRoutingModule } from './commodity-routing.module';

import { CommodityComponent } from './commodity.component';
import { CommodityListComponent } from './list/list.component';
import { CommodityFormComponent } from './form/form.component';
import { CommodityService } from './service/commodity.service';

@NgModule({
  imports: [SharedModule, CommodityRoutingModule],
  declarations: [CommodityComponent, CommodityListComponent, CommodityFormComponent],
  providers: [
    CommodityService,
    // ConfirmationService
  ],
})
export class CommodityModule {}
