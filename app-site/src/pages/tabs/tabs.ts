import { Component,ViewChild } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { IonicPage, NavController,NavParams,Tabs } from 'ionic-angular';

//在此将Tab1Root, Tab2Root, Tab3Root作为类引用
import { Tab1Root, Tab2Root, Tab3Root, Tab4Root } from '../';


@IonicPage({
  name: 'TabsPage',
  segment: 'tabs1'//添加路由
}
  
)
@Component({
  selector: 'page-tabs',
  templateUrl: 'tabs.html'
})
export class TabsPage {
  tab1Root: any = Tab1Root;
  tab2Root: any = Tab2Root;
  tab3Root: any = Tab3Root;
  tab4Root: any = Tab4Root;

  tab1Title = " ";
  tab2Title = " ";
  tab3Title = " ";
  
//定义相关传参的变量
public tabId: number;
public selectTabIndex: number;
@ViewChild('myTabs') tabRef: Tabs;


//国际多语言化  可以作为模板使用
  constructor(public navCtrl: NavController, public translateService: TranslateService, public params: NavParams) {
    translateService.get(['TAB1_TITLE', 'TAB2_TITLE', 'TAB3_TITLE']).subscribe(values => {
      this.tab1Title = values['TAB1_TITLE'];
      this.tab2Title = values['TAB2_TITLE'];
      this.tab3Title = values['TAB3_TITLE'];
    });

    //初始化tabs选择
        /*  this.tabId = params.get("tabId");
          if(this.tabId != undefined || this.tabId !=null)
          {
            this.selectTabIndex = this.tabId;
          }    */

     // this.tabRef.select(1);
      }

      //生命周期的利用
      ionViewDidLoad() {
        this.tabRef.select(2);
      }
}
