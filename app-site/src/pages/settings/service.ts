import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class SettingsService {

    constructor(private http: Http) {}
    
    getAccounts(){
      let url = baseUrl + "user_vip";
      let p = {openid: localStorage.getItem("openid")};
      return this.http.get(url, getTokenOptions(p)).toPromise().then(res => {return res.json()});      
    }

    getOrders(){
      let url = baseUrl + "orders";
      let p = {openid: localStorage.getItem("openid")};
      return this.http.get(url, getTokenOptions(p)).toPromise().then(res => {return res.json()});      
    }

    getAppointments(){
      let url = baseUrl + "appointments";
      let p = {openid: localStorage.getItem("openid")};
      return this.http.get(url, getTokenOptions(p)).toPromise().then(res => {return res.json()});      
    }

    getRecords(){
      let url = baseUrl + "consumption_records";
      let p = {openid: localStorage.getItem("openid")};
      return this.http.get(url, getTokenOptions(p)).toPromise().then(res => {return res.json()});      
    }

    
  
}