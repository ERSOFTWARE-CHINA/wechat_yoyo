import 'rxjs/add/operator/toPromise';

import { Injectable } from '@angular/core';

import { Api } from '../api/api';


/*
 这是个获取产品的服务分装了和小白接口的数据获取
*/
@Injectable()
export class Products {

  public _list: any;

  constructor(public api: Api) { }
  /**
   * 向接口发送信息并获得数据
   */
  getList(accountInfo: any) {
    let seq = this.api.get('/?&service=App.Table.FreeQuery', accountInfo).share();
    seq.subscribe((res: any) => {
      // I如果成功获取显示相应的数据
      if (res.ret == '200') {//200表示获取成功
        this._getList(res);         
      } else {       
      }
    }, err => {
      console.error('ERROR', err);
    });

    return seq;
  }


  /**
   * 获取产品的列表
   */
  _getList(resp) {
    this._list = resp.data.list;
  }
}
