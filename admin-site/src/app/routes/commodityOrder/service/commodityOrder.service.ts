import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { baseUrl } from '../../../config';
import { getOptionWithParams, getFormData } from '../../../utils/formmat';

@Injectable()
export class CommodityOrderService {
  constructor(private http: HttpClient) {}
  url = baseUrl + '/api/v1/orders';

  commodityOrder: any = null;
  isUpdate = false;

  listOnePage(q: any) {
    return this.http.get(this.url, getOptionWithParams(q));
  }

  delivery(obj) {
    const p = {
      order: { status: 'd', delivery_info: obj.delivery_info },
    };
    return this.http.put(this.url + `/${obj.id}`, p);
  }

  cancel(obj) {
    const p = {
      order: { status: 'c' },
    };
    return this.http.put(this.url + `/${obj.id}`, p);
  }
}
