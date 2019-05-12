import { HttpClient, HttpClientModule } from '@angular/common/http';
import { ErrorHandler, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { Camera } from '@ionic-native/camera';
import { SplashScreen } from '@ionic-native/splash-screen';
import { StatusBar } from '@ionic-native/status-bar';
import { IonicStorageModule, Storage } from '@ionic/storage';
import { TranslateLoader, TranslateModule } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';

import { Items } from '../mocks/providers/items';
import { Settings, User, Api, Toast } from '../providers';
import { MyApp } from './app.component';
//消息框引入
//import { ToastController } from 'ionic-angular';
import { Wuzhapi } from '../providers/wuzhapi/wuzhapi';
import { Logger } from '../providers/logger/logger';
import { Products } from '../providers/products/products';

//自定义组件的引入
import { ComponentsModule } from '../components/components.module';

//测试组件模式

// The translate loader needs to know where to load i18n files
// in Ionic's static asset pipeline.
export function createTranslateLoader(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
}

export function provideSettings(storage: Storage) {
  /**
   * The Settings provider takes a set of default settings for your app.
   *
   * You can add new settings options at any time. Once the settings are saved,
   * these values will not overwrite the saved values (this can be done manually if desired).
   */
  return new Settings(storage, {
    option1: true,
    option2: 'Ionitron J. Framework',
    option3: '3',
    option4: 'Hello'
  });
}

@NgModule({
  declarations: [
    MyApp    
  ],
  imports: [
    BrowserModule,
    HttpClientModule, 
    //ComponentsModule,   
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: (createTranslateLoader),
        deps: [HttpClient]
      }
    }),
    IonicModule.forRoot(MyApp, {        
      backButtonIcon: 'arrow-dropleft-circle' // 配置返回按钮的图标  
    }),    
    IonicStorageModule.forRoot()
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,  
  ],
  providers: [
    Api,
    Items,
    User,
    Camera,
   // ToastController,  //因为在toast服务中进行封装了所以在此不需要再引用toastcontroller了
    SplashScreen,
   // ComponentsModule,
    StatusBar,
    { provide: Settings, useFactory: provideSettings, deps: [Storage] },
    // Keep this to enable Ionic's runtime error handling during development
    { provide: ErrorHandler, useClass: IonicErrorHandler },    
    Toast,
    Wuzhapi,
    Logger,
    Products
  ]
})
export class AppModule { }
