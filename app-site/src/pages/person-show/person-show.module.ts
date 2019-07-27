import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { PersonShowPage } from './person-show';

@NgModule({
  declarations: [
    PersonShowPage,
  ],
  imports: [
    IonicPageModule.forChild(PersonShowPage),
  ],
})
export class PersonShowPageModule {}
