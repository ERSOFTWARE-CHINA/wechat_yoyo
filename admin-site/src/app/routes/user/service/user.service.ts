import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { baseUrl } from '../../../config';
import { getOptionWithParams } from '../../../utils/formmat';



@Injectable()
export class UserService {

  constructor(private http: HttpClient) { }
  url = baseUrl + "/api/v1/users"

  formOperation = "create";
  isUpdate = false;

  listOnePage(q: any) {
    return this.http.get(this.url, getOptionWithParams(q));
  }

  add(obj) {
    let param = { user: obj }
    return this.http.post(this.url, param);
  }

  delete(id) {
    return this.http.delete(this.url + `/${id}`);
  }
}