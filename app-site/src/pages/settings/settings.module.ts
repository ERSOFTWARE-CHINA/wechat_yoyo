import { NgModule } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { IonicPageModule } from 'ionic-angular';

import { SettingsPage } from './settings';
import { SettingsService } from './service';

@NgModule({
  declarations: [
    SettingsPage,
  ],
  imports: [
    IonicPageModule.forChild(SettingsPage),
    TranslateModule.forChild()
  ],
  exports: [
    SettingsPage
  ],
  providers: [
    SettingsService
  ]
})
export class SettingsPageModule { }
