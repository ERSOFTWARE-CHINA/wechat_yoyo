import { Component, OnInit, ViewChild, TemplateRef, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { tap, map } from 'rxjs/operators';
import { STComponent, STColumn, STData, STChange } from '@delon/abc';

import { UserService } from '../service/user.service';

@Component({
  selector: 'user-list',
  templateUrl: './list.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class UserListComponent implements OnInit {

  title = "用户管理"
  q: any = {
    pi: 1,
    ps: 10,
    sorter: '',
    status: null,
    statusList: [],
  };
  data: any[] = [];
  loading = false;
  status = [
    { index: 0, text: '已激活', value: true, type: 'success', checked: false },
    { index: 1, text: '已禁用', value: false, type: 'error', checked: false },
  ];
  admin_status = [
    { index: 0, text: '普通用户', value: false, type: 'success', checked: false },
    { index: 1, text: '管理员', value: true, type: 'error', checked: false },
  ];
  @ViewChild('st')
  st: STComponent;
  columns: STColumn[] = [
    // { title: '', index: 'key', type: 'checkbox' },
    { title: '用户名称', index: 'name' },
    { title: '微信昵称', index: 'wechat_nickname' },
    { title: '手机号码', index: 'mobile' },
    // {
    //   title: '服务调用次数',
    //   index: 'callNo',
    //   type: 'number',
    //   format: (item: any) => `${item.callNo} 万`,
    //   sorter: (a: any, b: any) => a.callNo - b.callNo,
    // },
    {
      title: '状态',
      index: 'status',
      render: 'status',
      // filter: {
      //   menus: this.status,
      //   fn: (filter: any, record: any) => record.status === filter.index,
      // },
    },
    {
      title: '管理员',
      index: 'admin_status',
      render: 'admin_status',
      // filter: {
      //   menus: this.status,
      //   fn: (filter: any, record: any) => record.status === filter.index,
      // },
    },
    // {
    //   title: '更新时间',
    //   index: 'updatedAt',
    //   type: 'date',
    //   sort: {
    //     compare: (a: any, b: any) => a.updatedAt - b.updatedAt,
    //   },
    // },
    {
      title: '操作',
      buttons: [
        {
          text: '修改',
          click: (item: any) => this.msg.success(`配置${item.no}`),
        },
        {
          text: '删除',
          click: (item: any) => this.msg.success(`订阅警报${item.no}`),
        },
      ],
    },
  ];
  selectedRows: STData[] = [];
  description = '';
  totalCallNo = 0;
  expandForm = false;

  constructor(
    private http: _HttpClient,
    public msg: NzMessageService,
    private modalSrv: NzModalService,
    private cdr: ChangeDetectorRef,
    private srv: UserService,
  ) { }

  ngOnInit() {
    this.getData();
  }

  getData() {
    // this.loading = true;
    // this.srv.listOnePage(null)
    //   .pipe(tap(() => (this.loading = false)))
    //   .subscribe(resp => {
    //     console.log("now set loading to false, and data is :")
    //     this.data = resp['data'];
    //     console.log(this.data);
    //     this.loading = false;
    //   },
    //     error => { this.msg.error(error); this.loading = false; }
    //   )

    this.loading = true;
    this.q.statusList = this.status.filter(w => w.checked).map(item => item.index);
    if (this.q.status !== null && this.q.status > -1) this.q.statusList.push(this.q.status);
    // this.http
    //   .get('/rule', this.q)
    this.srv.listOnePage(null)
      .pipe(
        map((resp: any) =>
          resp['data'].map(i => {
            const statusItem = this.status[i.status];
            i.statusText = statusItem.text;
            i.statusType = statusItem.type;
            return i;
          }),
        ),
        tap(() => (this.loading = false)),
      )
      .subscribe(res => {
        console.log("data is :");
        console.log(res);
        this.data = res;
        this.cdr.detectChanges();
      });
  }

  // stChange(e: STChange) {
  //   switch (e.type) {
  //     case 'checkbox':
  //       this.selectedRows = e.checkbox!;
  //       this.totalCallNo = this.selectedRows.reduce((total, cv) => total + cv.callNo, 0);
  //       this.cdr.detectChanges();
  //       break;
  //     case 'filter':
  //       this.getData();
  //       break;
  //   }
  // }

  remove() {
    this.http.delete('/rule', { nos: this.selectedRows.map(i => i.no).join(',') }).subscribe(() => {
      this.getData();
      this.st.clearCheck();
    });
  }

  approval() {
    this.msg.success(`审批了 ${this.selectedRows.length} 笔`);
  }

  add(tpl: TemplateRef<{}>) {
    this.modalSrv.create({
      nzTitle: '新建规则',
      nzContent: tpl,
      nzOnOk: () => {
        this.loading = true;
        this.http.post('/rule', { description: this.description }).subscribe(() => this.getData());
      },
    });
  }

  reset() {
    // wait form reset updated finished
    setTimeout(() => this.getData());
  }
}