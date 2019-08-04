import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class AppointmentService {

    constructor(private http: Http) {}
    
    url = baseUrl+"appointments"

    // 获取所有当天有效的预约
    list(date,service_id, technician_id) {
        let p = {status: "0", date: date, service_id: service_id, technician_id: technician_id}
        return this.http.get(this.url, getTokenOptions(p))
         .toPromise().then(res => {return res.json()})           
    }

    create(p) {
      let params = {
        appointment: p
      }
      return this.http.post(this.url, params, getTokenOptions(null))
         .toPromise().then(res => {return res.json()})   
    }

    
  
}