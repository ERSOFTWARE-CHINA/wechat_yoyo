import { Component, OnInit, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { NzMessageService } from 'ng-zorro-antd';
import { UploadFile } from 'ng-zorro-antd';

import { PostService } from '../service/post.service';

@Component({
  // tslint:disable-next-line: component-selector
  selector: 'post-form',
  templateUrl: './form.component.html',
  styles: [
    `
      i[nz-icon] {
        font-size: 32px;
        color: #999;
      }
      .ant-upload-text {
        margin-top: 8px;
        color: #666;
      }
    `,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class PostFormComponent implements OnInit {
  form: FormGroup;
  submitting = false;
  title = '商品表单';
  post: any = {};
  avatarURL01: any = '';
  avatarURL02: any = '';
  avatarURL03: any = '';
  avatarURLDetail: any = '';

  dateFormat = 'yyyy-MM-dd'

  // 照片墙=======================start
  showUploadList = {
    showPreviewIcon: true,
    showRemoveIcon: true,
    hidePreviewIconInNonImage: true,
  };
  fileList = [
    // {
    //   uid: -1,
    //   name: 'xxx.png',
    //   status: 'done',
    //   url: 'https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png',
    // },
  ];
  previewImage: string | undefined = '';
  previewVisible = false;
  handlePreview = (file: UploadFile) => {
    this.previewImage = file.url || file.thumbUrl;
    this.previewVisible = true;
  };
  // 照片墙=======================end

  technicians = [];

  constructor(
    private fb: FormBuilder,
    private msg: NzMessageService,
    private cdr: ChangeDetectorRef,
    private router: Router,
    private srv: PostService,
  ) { }

  ngOnInit(): void {
    if (this.srv.isUpdate) this.initUpdate();

    this.getTechnicians();
    this.setTitle();
    // this.srv.getTechnicians().subscribe(resp => {
    //   this.technicians = resp['data'];
    this.form = this.fb.group({
      title: [
        this.post.title ? this.post.title : null,
        Validators.compose([Validators.required, Validators.minLength(1)]),
      ],
      date: [this.post.date ? this.post.date : null, []],
      technician: [this.post.author ? this.post.author.id : null, [Validators.required]],
      content: [this.post.content ? this.post.content : null, []],
    });
    console.log(this.form.controls["technician"].value)
    // })
  }

  submit() {
    if (!this.srv.isUpdate) {
      this.submitting = true;
      const obj = this.format();
      this.srv.add(obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/posts/page');
        this.cdr.detectChanges();
      });
    } else {
      this.submitting = true;
      const obj = this.format();
      this.srv.update(this.post.id, obj).subscribe(resp => {
        this.submitting = false;
        if (resp['data']) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/posts/page');
        this.cdr.detectChanges();
      });
    }
  }

  setTitle() {
    if (this.srv.isUpdate) {
      this.title = '修改作品';
    } else this.title = '发布作品';
  }

  initUpdate() {
    this.setTitle();
    this.post = this.srv.post;
    // this.fileList = this.srv.post.post_images;
    // console.log(this.fileList);
  }

  getTechnicians() {
    this.srv.getTechnicians().subscribe(resp => {
      this.technicians = resp['data'];
      // this.form.controls["technician"].setValue() 
    });
  }

  format() {
    const obj = {
      title: this.form.controls['title'].value,
      date: this.form.controls['date'].value,
      technician: this.form.controls['technician'].value,
      content: this.form.controls['content'].value,
    };
    let fl = this.fileList;
    for (const i in fl) {
      fl[i] = fl[i]['originFileObj']
    }
    Object.assign(obj, fl)
    return obj;
  }
}
