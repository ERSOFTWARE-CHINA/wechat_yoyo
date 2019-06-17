import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class ShoppingSrvService {

    constructor(private http: Http) {}
    
    url = baseUrl+"services"

    listOnePage(q) {
        return this.http.get(this.url, getTokenOptions(q))
         .toPromise().then(res => {return res.json()})           
    }

    
  
}