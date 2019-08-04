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

    getServiceOrders(){
      let url = baseUrl + "service_orders";
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

    setInfo(data){
      let url = baseUrl + "users/set/info";
      let p = {openid: localStorage.getItem("openid"), user: data };
      return this.http.put(url, p, getTokenOptions(null)).toPromise().then(res => {return res.json()});  
    }

    pay(v) {
      return this.http.post(baseUrl+"/orders/pay/order", v, getTokenOptions(null)).toPromise().then(res => {return res.json()});
    }

    pay_service_order(v) {
      return this.http.post(baseUrl+"/service_orders/pay/service_order", v, getTokenOptions(null)).toPromise().then(res => {return res.json()});
    }

    cancel_appointment(i) {
      let url = baseUrl + `appointments/${i.id}`;
      let p = {appointment: {status:  "-1"}}
      return this.http.put(url, p, getTokenOptions(null)).toPromise().then(res => {return res.json()});  
    }

    
  
}