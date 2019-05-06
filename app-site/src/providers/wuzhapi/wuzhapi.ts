import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import {Observable} from "rxjs";
import {RequestMethods} from "./RequestMethods";
import {Logger} from "../logger/logger";

/*
 自定义api分装类
*/
@Injectable()
export class Wuzhapi {
   
  constructor(private httpClient: HttpClient, private logger: Logger) {
    logger.log("HttpProvider Init OK");
  }
 
  /**
   * 发起一个get请求
   * @param url
   * @param paramMap
   * @param header
   */
  get(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.GET, header);
  }
 
  /**
   * 发起一个post请求
   * @param url
   * @param paramMap
   * @param header
   */
  post(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.POST, header);
  }
 
  /**
   * 发起一个delete请求
   * @param url
   * @param paramMap
   * @param header
   */
  delete(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.DELETE, header);
  }
 
  /**
   * 发起一个options请求
   * @param url
   * @param paramMap
   * @param header
   */
  options(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.OPTIONS, header);
  }
 
  /**
   * 发起一个trace请求
   * @param url
   * @param paramMap
   * @param header
   */
  trace(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.TRACE, header);
  }
 
  /**
   * 发起一个head请求
   * @param url
   * @param paramMap
   * @param header
   * @constructor
   */
  HEAD(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.HEAD, header);
  }
 
  /**
   * 发起一个patch请求
   * @param url
   * @param paramMap
   * @param header
   */
  patch(url: string, paramMap: {} = {}, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, RequestMethods.PATCH, header);
  }
 
  /**
   * 通用的请求方法，通过传入RequestMethods不同以发起不用类型的请求。
   * 默认发起一个Get请求
   * @param url 必传参数
   * @param paramMap 默认为空
   * @param method 默认GET
   */
  request(url: string, paramMap: {} = {}, method: RequestMethods = RequestMethods.GET, header: {} = {}): Observable<object> {
    return this.sendRequest(url, paramMap, method, header);
  }
 
 
  protected sendRequest(url: string, paramMap: any = {}, method: RequestMethods = RequestMethods.GET, header: {} = {}): Observable<object> {
    this.logger.log("准备发起请求:");
    this.logger.log("请求路径:", url);
    this.logger.log("请求参数:", JSON.stringify(paramMap));
    this.logger.log("请求方法:", method);
    this.logger.log("请求头:", JSON.stringify(header));
    return Observable.create(observer => {
      this.httpClient.request(method, url, {params: paramMap, headers: header}).subscribe(
        (res) => {
          observer.next(res);
        }
      )
    })
  }
}
