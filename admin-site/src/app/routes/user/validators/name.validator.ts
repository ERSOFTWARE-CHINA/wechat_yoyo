import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { AbstractControl, AsyncValidatorFn } from '@angular/forms';
import { Observable, timer } from 'rxjs';
import { map, switchMap } from 'rxjs/operators';

import { baseUrl } from '../../../config';
import { getOptionWithParams } from '../../../utils/formmat';


@Injectable({
  providedIn: 'root'
})
export class UserValidators {
  constructor(private http: HttpClient) { }

  searchUser(text, id) {
    let p: any = {}
    if (id) {
      p = { name: text, id: id };
    } else p = { name: text }

    // debounce
    return timer(100)
      .pipe(
      switchMap(() => {
        // Check if username is available
        return this.http.get<any>(`${baseUrl}/api/v1/username/check`, { params: p })
      })
      );
  }

  userValidator(id): AsyncValidatorFn {

    return (control: AbstractControl): Observable<{ [key: string]: any } | null> => {
      return this.searchUser(control.value, id)
        .pipe(
        map(res => {
          // if username is already taken
          if (res['error']) {
            // return error
            return { 'userNameExists': true };
          }
        })
        );
    };

  }

}