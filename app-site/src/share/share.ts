import { Http, Headers, Response, RequestOptions, ResponseContentType } from '@angular/http';

//本地调试url
export const baseUrl = "http://localhost:4000/api/v1/"
// export const baseUrlRaw = "http://localhost:4000/"

//部署url
// export const baseUrl = "http://112.132.249.108:4000/admin_api/v1/"
// export const baseUrlRaw = "http://112.132.249.108:4000/"

export const userId = "weixin000001";
export const openId = "19820325";

export function getTokenOptions(paramsobj): RequestOptions{
  let headers = new Headers();
  let jwt = 'Bearer ' + localStorage.getItem('currentToken');
  headers.append('Authorization', jwt);
  headers.append('Content-Type', 'application/json');
  let options = new RequestOptions({ headers: headers, params: paramsobj });
  return options;
}