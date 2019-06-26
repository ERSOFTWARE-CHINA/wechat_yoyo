import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class VipService {

    constructor(private http: Http) {}
    
    url = baseUrl + "vip_cards"
    buy_url = baseUrl + "vip_orders"

    listOnePage(q) {
        return this.http.get(this.url, getTokenOptions(q))
         .toPromise().then(res => {return res.json()})           
    }

    buy(i) {
        let user = {wechat_openid: localStorage.getItem("openid")}
        let vip_card = {id: i.id}
        let p = {vip_order: { user: user, vip_card: vip_card}}
        return this.http.post(this.buy_url, p, getTokenOptions(null)).toPromise().then(res => {return res.json()})
    }



    
  
}