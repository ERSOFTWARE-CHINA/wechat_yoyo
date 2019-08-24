import { Injectable } from '@angular/core';
import { Http, URLSearchParams, RequestOptions, Headers, ResponseContentType } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { baseUrl, getTokenOptions } from '../../share/share';

@Injectable()
export class PersonShowService {

    constructor(private http: Http) {}
    
    url = baseUrl+"posts"

    list() {
        return this.http.get(this.url, getTokenOptions(null))
         .toPromise().then(res => {return res.json()})           
    }

    good(item) {
        const param = {
            add_good: true,
            good: item.good + 1
        }
        return this.http.put(this.url+`/${item.id}`, param, getTokenOptions(null))
         .toPromise().then(res => {return res.json()})       
    }

    getComments(post_id){
        const url = baseUrl + "post_comments"
        const param = { post_id: post_id }
        return this.http.get(url, getTokenOptions(param))
         .toPromise().then(res => {return res.json()})  
    }

    createComments(post_id, content){
        const user = {open_id: localStorage.getItem("openid")} 
        const post = {id: post_id}
        const url = baseUrl + "post_comments"
        const param = {user: user, post: post, content: content }
        return this.http.post(url, param, getTokenOptions(null))
         .toPromise().then(res => {return res.json()})  
    }

    
  
}