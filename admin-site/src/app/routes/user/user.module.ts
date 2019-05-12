import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared/shared.module';

import { UserRoutingModule } from './user-routing.module';

import { UserComponent } from './user.component';
import { UserListComponent } from './list/list.component';
import { UserFormComponent } from './form/form.component';
import { UserService } from './service/user.service';

@NgModule({
  imports: [SharedModule, UserRoutingModule],
  declarations: [
    UserComponent,
    UserListComponent,
    UserFormComponent
  ],
  providers: [
    UserService
    // ConfirmationService
  ]
})
export class UserModule { }

