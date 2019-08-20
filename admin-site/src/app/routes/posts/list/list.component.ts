import { Component, OnInit, ViewChild, TemplateRef, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { tap } from 'rxjs/operators';

import { PostService } from '../service/post.service';

@Component({
  selector: 'post-list',
  templateUrl: './list.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class PostListComponent implements OnInit {
  title = '作品管理';
  total = 0;
  q: any = {
    pi: 1,
    ps: 10,
    sort_field: 'date',
    sort_direction: 'desc',
    title: null,
  };
  data: any[] = [];
  loading = false;

  expandForm = false;

  constructor(
    private http: _HttpClient,
    public msg: NzMessageService,
    private modalSrv: NzModalService,
    private cdr: ChangeDetectorRef,
    private srv: PostService,
    private router: Router,
  ) { }

  ngOnInit() {
    this.getData();
  }

  getData() {
    this.loading = true;
    this.srv
      .listOnePage(this.q)
      .pipe(tap(() => (this.loading = false)))
      .subscribe(
        resp => {
          this.data = resp['data'];
          console.log(this.data);
          this.cdr.detectChanges();
          this.loading = false;
        },
        error => {
          this.loading = false;
        },
      );
  }

  add(tpl: TemplateRef<{}>) {
    this.srv.isUpdate = false;
    this.router.navigateByUrl('/posts/form');
  }

  modify(id) {
    // this.srv.formOperation = 'create';
    this.srv.isUpdate = true;
    this.srv.getById(id).subscribe(resp => {
      this.srv.post = resp['data'];
      this.router.navigateByUrl('/posts/form');
    });
  }

  remove(item) {
    this.modalSrv.create({
      nzTitle: '确认删除',
      nzContent: '确认要删除该条记录吗？',
      nzOnOk: () => {
        this.loading = true;
        this.srv.delete(item.id).subscribe(
          resp => {
            if (resp['data']) this.msg.success(`删除成功！`);
            this.getData();
          },
          error => {
            this.loading = false;
          },
        );
      },
    });
  }

  reset() {
    setTimeout(() => this.getData());
  }

  pageChange(pi: number) {
    this.q.pi = pi;
    this.getData();
  }

  sort(sort: { key: string; value: string }): void {
    this.q.sort_field = sort.key;
    this.q.sort_direction = sort.value;
    this.getData();
  }
}
