import { Component, OnInit, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Observer } from 'rxjs';
import { map, delay, debounceTime } from 'rxjs/operators';
import { NzMessageService } from 'ng-zorro-antd';
import { UploadFile } from 'ng-zorro-antd';

import { ServiceService } from '../service/service.service';
import { getFormData } from '../../../utils/formmat';

@Component({
  // tslint:disable-next-line: component-selector
  selector: 'service-form',
  templateUrl: './form.component.html',
  // styleUrls: ['./form.component.less'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ServiceFormComponent implements OnInit {
  form: FormGroup;
  submitting = false;
  title = '服务类产品表单';
  service: any = {};
  avatarURL01: any = '';
  avatarURLDetail: any = '';

  constructor(
    private fb: FormBuilder,
    private msg: NzMessageService,
    private cdr: ChangeDetectorRef,
    private router: Router,
    private srv: ServiceService,
  ) { }

  ngOnInit(): void {
    if (this.srv.isUpdate) this.initUpdate();
    this.setTitle();
    this.form = this.fb.group({
      sname: [
        this.service.sname ? this.service.sname : null,
        Validators.compose([Validators.required, Validators.minLength(3)]),
      ],
      times: [this.service.times ? this.service.times : null, []],
      original_price: [this.service.original_price ? this.service.original_price : null, []],
      current_price: [this.service.current_price ? this.service.current_price : null, []],
      desc: [this.service.desc ? this.service.desc : null, []],
    });
  }

  submit() {
    if (!this.srv.isUpdate) {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file01) obj.image_01 = this.fileList01[0];
      if (this.fileDetail) obj.image_detail = this.fileListDetail[0];
      this.srv.add(obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/service/page');
        this.cdr.detectChanges();
      });
    } else {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file01) obj.image_01 = this.fileList01[0];
      if (this.fileDetail) obj.image_detail = this.fileListDetail[0];
      this.srv.update(this.service.id, obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/service/page');
        this.cdr.detectChanges();
      });
    }
  }

  setTitle() {
    if (this.srv.isUpdate) {
      this.title = '修改服务产品';
    } else this.title = '创建服务产品';
  }

  initUpdate() {
    this.setTitle();
    this.service = this.srv.service;
    this.avatarURL01 = this.service.image_01;
    this.avatarURLDetail = this.service.image_detail;
  }

  fileList01: UploadFile[] = [];
  file01: any = null;
  beforeUpload01 = (file: UploadFile): boolean => {
    this.fileList01 = [file];
    this.file01 = file;
    return false;
  };

  fileListDetail: UploadFile[] = [];
  fileDetail: any = null;
  beforeUploadDetail = (file: UploadFile): boolean => {
    this.fileListDetail = [file];
    this.fileDetail = file;
    return false;
  };
}
