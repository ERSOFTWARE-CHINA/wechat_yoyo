import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class VipService {

    constructor(private http: Http) {}
    
    url = baseUrl + "vip_cards"
    buy_url = baseUrl + "user_vip/buy"

    listOnePage(q) {
        return this.http.get(this.url, getTokenOptions(q))
         .toPromise().then(res => {return res.json()})           
    }

    buy(i) {
        let p = { card_id: i.id, openid: localStorage.getItem("openid") }
        return this.http.post(this.buy_url, p, getTokenOptions(null)).toPromise().then(res => {return res.json()})
    }



    
  
}