import { Component, OnInit, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { map, delay, debounceTime } from 'rxjs/operators';
import { NzMessageService } from 'ng-zorro-antd';
import { UserValidators } from '../validators/name.validator';
import { UserService } from '../service/user.service';

@Component({
  selector: 'user-form',
  templateUrl: './form.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UserFormComponent implements OnInit {
  form: FormGroup;
  submitting = false;
  title = "用户表单";
  user: any = null;

  constructor(
    private fb: FormBuilder,
    private msg: NzMessageService,
    private cdr: ChangeDetectorRef,
    private router: Router,
    private srv: UserService,
    private userNameValidator: UserValidators) { }

  ngOnInit(): void {
    this.setTitle();
    this.form = this.fb.group({
      name: [null, Validators.compose(
        [Validators.required, Validators.minLength(3)]), this.userNameValidator.userValidator()],
      mobile: [null, []],
    });
  }

  submit() {
    this.submitting = true;
    this.srv.add(this.form.value).subscribe(resp => {
      this.submitting = false;
      if (resp["data"]) this.msg.success(`保存成功！`);
      this.router.navigateByUrl('/user/page');
      this.cdr.detectChanges();
    });
  }

  setTitle() {
    if (this.srv.formOperation == "create") {
      this.title = "创建用户";
    }
    if (this.srv.formOperation == "update") {
      this.title = "修改用户";
    }
  }


}