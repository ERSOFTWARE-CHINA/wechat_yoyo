import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { baseUrl } from '../../../config';
import { getOptionWithParams, getFormData } from '../../../utils/formmat';

@Injectable()
export class AppointmentService {
  constructor(private http: HttpClient) {}
  url = baseUrl + '/api/v1/appointments';

  appointment: any = null;
  isUpdate = false;

  listOnePage(q: any) {
    return this.http.get(this.url, getOptionWithParams(q));
  }

  complete(i) {
    const q = { appointment: { status: '1' } };
    return this.http.put(this.url + `/${i.id}`, q);
  }

  cancel(i) {
    const q = { appointment: { status: '-1' } };
    return this.http.put(this.url + `/${i.id}`, q);
  }
}
