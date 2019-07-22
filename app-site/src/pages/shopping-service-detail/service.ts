import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class ServiceDetailService {

    constructor(private http: Http) {}
    
    url = baseUrl+"service_orders"

    buy(v){
      return this.http.post(this.url, v, getTokenOptions(null)).toPromise().then(res => {return res.json()});
    }

    pay(v) {
      return this.http.post(this.url+"/pay/service_order", v, getTokenOptions(null)).toPromise().then(res => {return res.json()});
    }

    
  
}