import { Component, OnInit, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Observer } from 'rxjs';
import { map, delay, debounceTime } from 'rxjs/operators';
import { NzMessageService } from 'ng-zorro-antd';
import { UploadFile } from 'ng-zorro-antd';
import { UserValidators } from '../validators/name.validator';
import { UserService } from '../service/user.service';
import { getFormData } from '../../../utils/formmat';

@Component({
  selector: 'user-form',
  templateUrl: './form.component.html',
  // styleUrls: ['./form.component.less'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UserFormComponent implements OnInit {
  form: FormGroup;
  submitting = false;
  title = '用户表单';
  user: any = {};
  avatarURL: any = '';

  constructor(
    private fb: FormBuilder,
    private msg: NzMessageService,
    private cdr: ChangeDetectorRef,
    private router: Router,
    private srv: UserService,
    private userNameValidator: UserValidators,
  ) {}

  ngOnInit(): void {
    if (this.srv.isUpdate) this.initUpdate();
    this.setTitle();
    this.form = this.fb.group({
      name: [
        this.user.name ? this.user.name : null,
        Validators.compose([Validators.required, Validators.minLength(2)]),
        this.userNameValidator.userValidator(this.user.id),
      ],
      mobile: [this.user.mobile ? this.user.mobile : null, []],
    });
  }

  submit() {
    if (!this.srv.isUpdate) {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file) obj.avatar = this.fileList[0];
      this.srv.add(obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/user/page');
        this.cdr.detectChanges();
      });
    } else {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file) obj.avatar = this.fileList[0];
      this.srv.update(this.user.id, obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/user/page');
        this.cdr.detectChanges();
      });
    }
  }

  setTitle() {
    if (this.srv.isUpdate) {
      this.title = '修改用户';
    } else this.title = '创建用户';
  }

  initUpdate() {
    this.setTitle();
    this.user = this.srv.user;
    this.avatarURL = this.user.avatar;
  }

  fileList: UploadFile[] = [];
  file: any = null;
  beforeUpload = (file: UploadFile): boolean => {
    this.fileList = [file];
    this.file = file;
    return false;
  };
}
