import { Component, OnInit, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Observer } from 'rxjs';
import { map, delay, debounceTime } from 'rxjs/operators';
import { NzMessageService } from 'ng-zorro-antd';
import { UploadFile } from 'ng-zorro-antd';

import { CommodityService } from '../service/commodity.service';
import { getFormData } from '../../../utils/formmat';

@Component({
  selector: 'commodity-form',
  templateUrl: './form.component.html',
  // styleUrls: ['./form.component.less'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class CommodityFormComponent implements OnInit {
  form: FormGroup;
  submitting = false;
  title = '产品表单';
  commodity: any = {};
  avatarURL: any = '';

  constructor(
    private fb: FormBuilder,
    private msg: NzMessageService,
    private cdr: ChangeDetectorRef,
    private router: Router,
    private srv: CommodityService,
  ) {}

  ngOnInit(): void {
    if (this.srv.isUpdate) this.initUpdate();
    this.setTitle();
    this.form = this.fb.group({
      name: [
        this.commodity.name ? this.commodity.name : null,
        Validators.compose([Validators.required, Validators.minLength(3)]),
      ],
      mobile: [this.commodity.name ? this.commodity.name : null, []],
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
        this.router.navigateByUrl('/commodity/page');
        this.cdr.detectChanges();
      });
    } else {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file) obj.avatar = this.fileList[0];
      this.srv.update(this.commodity.id, obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/commodity/page');
        this.cdr.detectChanges();
      });
    }
  }

  setTitle() {
    if (this.srv.isUpdate) {
      this.title = '修改产品';
    } else this.title = '创建产品';
  }

  initUpdate() {
    this.setTitle();
    this.commodity = this.srv.commodity;
    this.avatarURL = this.commodity.avatar;
  }

  fileList: UploadFile[] = [];
  file: any = null;
  beforeUpload = (file: UploadFile): boolean => {
    this.fileList = [file];
    this.file = file;
    return false;
  };
}
