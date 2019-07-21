import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';

import 'rxjs/add/operator/map';
import 'rxjs/add/operator/toPromise';

import { baseUrl, getTokenOptions } from '../../share/share';
// import { userId } from '../../shared/shared';

@Injectable()
export class WechatService {

    constructor(private http: Http) {}

    // getOpenId() {
    //     let code = localStorage.getItem("code")
    //     let url = baseUrlRaw + `openid?code=${code}`;
    //     return this.http.get(url)
    //         .toPromise().then(res => {return res.json()})   
    // }

    auto_login(open_id) {
        let param = {openid: open_id}
        return this.http.get(baseUrl + "user_vip", getTokenOptions(param))
          .map(response => response.json()).toPromise().then(resp => {if (resp.data) { this.setUserInfo(resp.data)}});        
    }

    setUserInfo(data) {
      this.setValue("full_name", data.full_name);
      this.setValue("mobile", data.mobile);
      this.setValue("address", data.address);
      this.setValue("card_name", data.card_name);
      this.setValue("remainder", data.remainder);
    }

    setValue(key: string, value: any) {
      if ((value)&&(value!="")) localStorage.setItem(key, value) 
    }
}
