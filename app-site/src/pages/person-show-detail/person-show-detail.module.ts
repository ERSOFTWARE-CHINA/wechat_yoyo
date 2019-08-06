import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { PersonShowDetailPage } from './person-show-detail';

@NgModule({
  declarations: [
    PersonShowDetailPage,
  ],
  imports: [
    IonicPageModule.forChild(PersonShowDetailPage),
  ],

})
export class PersonShowDetailPageModule {}
