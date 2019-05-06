import { Injectable } from '@angular/core';
/**
导入ionic消息提示框模块ToastController
*/
import { ToastController } from "ionic-angular";

/*
  Generated class for the ToastServiceProvider provider.

  See https://angular.io/guide/dependency-injection for more info on providers
  and Angular DI.
*/
@Injectable()
export class Toast {

//自己定义的三种消息框样式
  errorCss='errorToast'
  generalCss='generalToast'
  successCss='successToast'

/**
构造函数引入
*/
  constructor(public toast:ToastController) {
    console.log('Hello ToastServiceProvider Provider');
  }

  /**
   * 错误信息提示框
   * @param message 消息
   */
  errorToast(message:any){
    this.presentToast(message,this.errorCss);
  }

  /**
   * 普通信息提示框
   * @param message 消息
   */
  generalToast(message:any){
    this.presentToast(message,this.generalCss);
  }

  /**
   * 成功信息提示框
   * @param message
   */
  successToast(message:any){
    this.presentToast(message,this.successCss);
  }

  /**
   *
   * @param message需要展示的信息
   * @param css 自定义的背景颜色
   */
  presentToast(message:any,css:string) {
    let toast = this.toast.create({
      message: message,//提示消息内容
      duration: 2000,//显示时长，单位毫秒
      position: 'top',//消息框出现的位置，bottom就是底端的意思，自然就有top和中间了
      showCloseButton:true,//是否有关闭按钮，true就是有
      cssClass:css,//自己给消息框定义的样式，css样式名称      
      closeButtonText:'关闭'//关闭按钮上的文字
    });

    toast.onDidDismiss(() => {
      console.log('Dismissed toast');
    });

    toast.present();//出发消息提示框
  }

}

