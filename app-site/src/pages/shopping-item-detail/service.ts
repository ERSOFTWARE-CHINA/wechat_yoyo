import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';
import { BuiltinType } from '@angular/compiler/src/output/output_ast';

@Injectable()
export class CommodityDetailService {

    constructor(private http: Http) {}
    
    url = baseUrl+"orders"

    buy(v){
      return this.http.post(this.url, v, getTokenOptions(null)).toPromise().then(res => {return res.json()});
    }

    
  
}