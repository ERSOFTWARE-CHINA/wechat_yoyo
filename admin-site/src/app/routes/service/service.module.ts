import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared/shared.module';

import { ServiceRoutingModule } from './service-routing.module';

import { ServiceComponent } from './service.component';
import { ServiceListComponent } from './list/list.component';
import { ServiceFormComponent } from './form/form.component';
import { ServiceService } from './service/service.service';

@NgModule({
  imports: [SharedModule, ServiceRoutingModule],
  declarations: [ServiceComponent, ServiceListComponent, ServiceFormComponent],
  providers: [
    ServiceService,
    // ConfirmationService
  ],
})
export class ServiceModule {}
