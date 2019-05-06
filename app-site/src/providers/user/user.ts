import 'rxjs/add/operator/toPromise';

import { Injectable } from '@angular/core';

import { Api } from '../api/api';

//原版的toast提示框插件
//import { ToastController } from 'ionic-angular';

//个人封装的toast插件
import { Toast } from  '../toast/toast'


/**
 * Most apps have the concept of a User. This is a simple provider
 * with stubs for login/signup/etc.
 *
 * This User provider makes calls to our API at the `login` and `signup` endpoints.
 *
 * By default, it expects `login` and `signup` to return a JSON object of the shape:
 *
 * ```json
 * {
 *   status: 'success',
 *   user: {
 *     // User fields your app needs, like "id", "name", "email", etc.
 *   }
 * }Ø
 * ```
 *
 * If the `status` field is not `success`, then an error is detected and returned.
 */
@Injectable()
export class User {
  _user: any;

  constructor(public api: Api,private toast: Toast /*private toastCtrl: ToastController*/) { }
  /**
   * Send a POST request to our login endpoint with the data
   * the user entered on the form.
   */
  login(accountInfo: any) {
    let seq = this.api.get('/?&service=App.User.Login', accountInfo).share();
    seq.subscribe((res: any) => {
      // If the API returned a successful response, mark the user as logged in
      if (res.ret == '200') {
        this._loggedIn(res);
      /*  let toast = this.toastCtrl.create({
          message: '成功登录了',
          duration: 3000,//3秒后自动消失
          position: 'top',//位置
          showCloseButton: true,
          closeButtonText: "关闭"
         }); 
         toast.onDidDismiss(() => { console.log('toast被关闭之后执行'); });
         toast.present();//符合触发条件后立即执行显示。一定不能忘了这个
         console.info('成功登录');*/
         this.toast.successToast('登录成功！')//使用toast插件

      } else {       
      }
    }, err => {
      console.error('ERROR', err);
    });

    return seq;
  }

  /**
   * Send a POST request to our signup endpoint with the data
   * the user entered on the form.
   */
  signup(accountInfo: any) {
    let seq = this.api.post('signup', accountInfo).share();

    seq.subscribe((res: any) => {
      // If the API returned a successful response, mark the user as logged in
      if (res.status == 'success') {
        this._loggedIn(res);
      }
    }, err => {
      console.error('ERROR', err);
    });

    return seq;
  }

  /**
   * Log the user out, which forgets the session
   */
  logout() {
    this._user = null;
  }

  /**
   * Process a login/signup response to store user data
   */
  _loggedIn(resp) {
    this._user = resp.user;
  }
}
