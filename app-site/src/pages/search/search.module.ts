import { NgModule } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';//国际化
import { IonicPageModule } from 'ionic-angular';

import { SearchPage } from './search';

@NgModule({
  declarations: [
    SearchPage,
  ],
  imports: [
    IonicPageModule.forChild(SearchPage),
    TranslateModule.forChild()
  ],
  exports: [
    SearchPage
  ]
})
export class SearchPageModule { }
