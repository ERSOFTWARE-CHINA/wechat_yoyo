import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { PersonShowPage } from './person-show';
import { PersonShowService } from './service';

@NgModule({
  declarations: [
    PersonShowPage
  ],
  imports: [
    IonicPageModule.forChild(PersonShowPage),
  ],
  providers: [
    PersonShowService
  ]
})
export class PersonShowPageModule {}
