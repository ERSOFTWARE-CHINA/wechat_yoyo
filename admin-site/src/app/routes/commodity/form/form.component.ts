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
  title = '商品表单';
  commodity: any = {};
  avatarURL01: any = '';
  avatarURL02: any = '';
  avatarURL03: any = '';
  avatarURLDetail: any = '';

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
      cname: [
        this.commodity.cname ? this.commodity.cname : null,
        Validators.compose([Validators.required, Validators.minLength(2)]),
      ],
      original_price: [this.commodity.original_price ? this.commodity.original_price : null, []],
      current_price: [this.commodity.current_price ? this.commodity.current_price : null, []],
      stock: [this.commodity.stock ? this.commodity.stock : null, []],
      desc: [this.commodity.desc ? this.commodity.desc : null, []],
    });
  }

  submit() {
    if (!this.srv.isUpdate) {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file01) obj.image_01 = this.fileList01[0];
      if (this.file02) obj.image_02 = this.fileList02[0];
      if (this.file03) obj.image_03 = this.fileList03[0];
      if (this.fileDetail) obj.image_detail = this.fileListDetail[0];
      this.srv.add(obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/commodity/page');
        this.cdr.detectChanges();
      });
    } else {
      this.submitting = true;
      let obj = this.form.value;
      if (this.file01) obj.image_01 = this.fileList01[0];
      if (this.file02) obj.image_02 = this.fileList02[0];
      if (this.file03) obj.image_03 = this.fileList03[0];
      if (this.fileDetail) obj.image_detail = this.fileListDetail[0];
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
      this.title = '修改商品';
    } else this.title = '创建商品';
  }

  initUpdate() {
    this.setTitle();
    this.commodity = this.srv.commodity;
    this.avatarURL01 = this.commodity.image_01;
    this.avatarURL02 = this.commodity.image_02;
    this.avatarURL03 = this.commodity.image_03;
    this.avatarURLDetail = this.commodity.image_detail;
  }

  fileList01: UploadFile[] = [];
  file01: any = null;
  beforeUpload01 = (file: UploadFile): boolean => {
    this.fileList01 = [file];
    this.file01 = file;
    return false;
  };

  fileList02: UploadFile[] = [];
  file02: any = null;
  beforeUpload02 = (file: UploadFile): boolean => {
    this.fileList02 = [file];
    this.file02 = file;
    return false;
  };

  fileList03: UploadFile[] = [];
  file03: any = null;
  beforeUpload03 = (file: UploadFile): boolean => {
    this.fileList03 = [file];
    this.file03 = file;
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
