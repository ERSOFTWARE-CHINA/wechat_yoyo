import { Component, OnInit, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable, Observer } from 'rxjs';
import { map, delay, debounceTime } from 'rxjs/operators';
import { NzMessageService } from 'ng-zorro-antd';
import { UploadFile } from 'ng-zorro-antd';
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
  user: any = {};

  constructor(
    private fb: FormBuilder,
    private msg: NzMessageService,
    private cdr: ChangeDetectorRef,
    private router: Router,
    private srv: UserService,
    private userNameValidator: UserValidators) { }

  ngOnInit(): void {
    if (this.srv.isUpdate) this.initUpdate();
    this.setTitle();
    this.form = this.fb.group({
      name: [this.user.name ? this.user.name : null, Validators.compose(
        [Validators.required, Validators.minLength(3)]), this.userNameValidator.userValidator(this.user.id)],
      mobile: [this.user.name ? this.user.name : null, []],
    });
  }

  submit() {
    if (!this.srv.isUpdate) {
      this.submitting = true;
      this.srv.add(this.form.value).subscribe(resp => {
        this.submitting = false;
        if (resp["data"]) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/user/page');
        this.cdr.detectChanges();
      });
    } else {
      this.submitting = true;
      this.srv.update(this.user.id, this.form.value).subscribe(resp => {
        this.submitting = false;
        if (resp["data"]) this.msg.success(`保存成功！`);
        this.router.navigateByUrl('/user/page');
        this.cdr.detectChanges();
      });
    }
  }

  setTitle() {
    if (this.srv.isUpdate) {
      this.title = "修改用户";
    } else this.title = "创建用户";
  }

  initUpdate() {
    this.setTitle();
    this.user = this.srv.user;
  }

  // 头像上传组件
  showUploadList = {
    showPreviewIcon: true,
    showRemoveIcon: true,
    hidePreviewIconInNonImage: true
  };

  fileList = [
    // {
    //   uid: -1,
    //   name: 'xxx.png',
    //   status: 'done',
    //   url: 'https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png'
    // }
  ];
  previewImage: string | undefined = '';
  previewVisible = false;

  handlePreview = (file: UploadFile) => {
    console.log(file);
    this.previewImage = file.url || file.thumbUrl;
    this.previewVisible = true;
  };

  //   //第二个测试上传组件
  //   loading = false;
  //   avatarUrl: string;

  //   beforeUpload = (file: File) => {
  //     return new Observable((observer: Observer<boolean>) => {
  //       const isJPG = file.type === 'image/jpeg';
  //       if (!isJPG) {
  //         this.msg.error('You can only upload JPG file!');
  //         observer.complete();
  //         return;
  //       }
  //       const isLt2M = file.size / 1024 / 1024 < 2;
  //       if (!isLt2M) {
  //         this.msg.error('Image must smaller than 2MB!');
  //         observer.complete();
  //         return;
  //       }
  //       // check height
  //       this.checkImageDimension(file).then(dimensionRes => {
  //         if (!dimensionRes) {
  //           this.msg.error('Image only 300x300 above');
  //           observer.complete();
  //           return;
  //         }

  //         observer.next(isJPG && isLt2M && dimensionRes);
  //         observer.complete();
  //       });
  //     });
  //   };

  //   private getBase64(img: File, callback: (img: string) => void): void {
  //     const reader = new FileReader();
  //     reader.addEventListener('load', () => callback(reader.result!.toString()));
  //     reader.readAsDataURL(img);
  //   }

  //   private checkImageDimension(file: File): Promise<boolean> {
  //     return new Promise(resolve => {
  //       const img = new Image(); // create image
  //       img.src = window.URL.createObjectURL(file);
  //       img.onload = () => {
  //         const width = img.naturalWidth;
  //         const height = img.naturalHeight;
  //         window.URL.revokeObjectURL(img.src!);
  //         resolve(width === height && width >= 300);
  //       };
  //     });
  //   }

  //   handleChange(info: { file: UploadFile }): void {
  //     switch (info.file.status) {
  //       case 'uploading':
  //         this.loading = true;
  //         break;
  //       case 'done':
  //         // Get this url from response in real world.
  //         this.getBase64(info.file!.originFileObj!, (img: string) => {
  //           this.loading = false;
  //           this.avatarUrl = img;
  //         });
  //         break;
  //       case 'error':
  //         this.msg.error('Network error');
  //         this.loading = false;
  //         break;
  //     }
  //   }
  // }


}