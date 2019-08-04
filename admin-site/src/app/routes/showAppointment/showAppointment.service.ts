import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { baseUrl } from '../../config';
import { getOptionWithParams, getFormData } from '../../utils/formmat';

@Injectable()
export class ShowAppointmentService {
  constructor(private http: HttpClient) {}
  url = baseUrl + '/api/v1/appointments';

  appointment: any = null;
  isUpdate = false;

  listOnePage(q: any) {
    return this.http.get(this.url, getOptionWithParams(q));
  }
}
