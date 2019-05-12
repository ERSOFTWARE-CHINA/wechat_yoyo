import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';



@Injectable()
export class UserService {

  constructor(private http: HttpClient) { }
  url = "http://localhost:4000/api/v1/users"
  listOnePage(q) {
    let headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    let options = {
      headers: headers
    }
    console.log(headers)
    return this.http.get(this.url, options);
  }

  getTokenOptions() {
    let headers = new HttpHeaders();
    let jwt = 'Bearer ' + localStorage.getItem('currentToken');
    headers.append('Authorization', jwt);
    headers.append('Content-Type', 'application/json');
    let options = { headers: headers };
    return options;
  }

}