import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class PersonShowService {

    constructor(private http: Http) {}
    
    url = baseUrl+"posts"

    list() {
        return this.http.get(this.url, getTokenOptions(null))
         .toPromise().then(res => {return res.json()})           
    }

    
  
}