import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared/shared.module';

import { TechnicianRoutingModule } from './technician-routing.module';

import { TechnicianComponent } from './technician.component';
import { TechnicianListComponent } from './list/list.component';
import { TechnicianFormComponent } from './form/form.component';
import { TechnicianService } from './service/technician.service';

@NgModule({
  imports: [SharedModule, TechnicianRoutingModule],
  declarations: [TechnicianComponent, TechnicianListComponent, TechnicianFormComponent],
  providers: [
    TechnicianService,
    // ConfirmationService
  ],
})
export class TechnicianModule {}
