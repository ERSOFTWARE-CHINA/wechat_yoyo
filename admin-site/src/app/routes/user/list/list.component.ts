import { Component, OnInit, ViewChild, TemplateRef, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { tap, map } from 'rxjs/operators';
import { STComponent, STColumn, STData, STChange } from '@delon/abc';

import { UserService } from '../service/user.service';
import { formmat } from '../../../utils/formmat';

@Component({
  selector: 'user-list',
  templateUrl: './list.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UserListComponent implements OnInit {
  title = '用户管理';
  total = 0;
  q: any = {
    pi: 1,
    ps: 10,
    sort_field: 'name',
    sort_direction: 'asc',
    name: null,
    wechat_nickname: null,
    mobile: null,
  };
  data: any[] = [];
  loading = false;
  listofstatus = [{ text: '已激活', value: true }, { text: '已禁用', value: false }];
  listoftypes = [{ text: '普通用户', value: false }, { text: '管理员', value: true }];

  expandForm = false;

  constructor(
    private http: _HttpClient,
    public msg: NzMessageService,
    private modalSrv: NzModalService,
    private cdr: ChangeDetectorRef,
    private srv: UserService,
    private router: Router,
  ) {}

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
    // this.srv.formOperation = 'create';
    this.srv.isUpdate = false;
    this.router.navigateByUrl('/user/form');
  }

  modify(id) {
    // this.srv.formOperation = 'create';
    this.srv.isUpdate = true;
    this.srv.getById(id).subscribe(resp => {
      console.log(resp);
      this.srv.user = resp['data'];
      this.router.navigateByUrl('/user/form');
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

  filter_status(searchStatus: boolean): void {
    this.q.active = searchStatus;
    this.getData();
  }

  filter_type(searchType: boolean): void {
    this.q.is_admin = searchType;
    this.getData();
  }
}
