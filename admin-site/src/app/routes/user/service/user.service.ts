import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { baseUrl } from '../../../config';
import { getOptionWithParams, getFormData } from '../../../utils/formmat';



@Injectable()
export class UserService {

  constructor(private http: HttpClient) { }
  url = baseUrl + "/api/v1/users"

  user: any = null;
  // formOperation = "create";
  isUpdate = false;

  listOnePage(q: any) {
    return this.http.get(this.url, getOptionWithParams(q));
  }

  getById(id) {
    return this.http.get(this.url + `/${id}`);
  }

  add(obj) {
    return this.http.post(this.url, getFormData(obj));
  }

  update(id, obj) {
    // let param = { user: obj }
    return this.http.put(this.url + `/${id}`, getFormData(obj));
  }

  delete(id) {
    return this.http.delete(this.url + `/${id}`);
  }
}