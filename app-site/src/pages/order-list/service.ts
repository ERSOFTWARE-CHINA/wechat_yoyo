import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class UserServiceService {

    constructor(private http: Http) {}
    
    url = baseUrl+"user_services/by_user"

    list(q) {
        let p = {openid: localStorage.getItem("openid")};
        return this.http.get(this.url, getTokenOptions(p))
         .toPromise().then(res => {return res.json()})           
    }

    
  
}