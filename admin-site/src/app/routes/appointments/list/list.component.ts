import { Component, OnInit, ViewChild, TemplateRef, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { tap, map } from 'rxjs/operators';
import { STComponent, STColumn, STData, STChange } from '@delon/abc';

import { AppointmentService } from '../service/appointment.service';
import { formmat } from '../../../utils/formmat';

@Component({
  templateUrl: './list.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AppointmentListComponent implements OnInit {
  title = '预约管理';
  total = 0;
  q: any = {
    pi: 1,
    ps: 10,
    sort_field: 'date',
    sort_direction: 'desc',
    cname: null,
  };
  data: any[] = [];
  loading = false;

  expandForm = false;

  constructor(
    private http: _HttpClient,
    public msg: NzMessageService,
    private modalSrv: NzModalService,
    private cdr: ChangeDetectorRef,
    private srv: AppointmentService,
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
    this.srv.isUpdate = false;
    this.router.navigateByUrl('/appointment/form');
  }

  complete(item) {
    // this.srv.formOperation = 'create';
    this.srv.isUpdate = true;
    this.srv.complete(item).subscribe(
      resp => {
        if (resp['data']) this.msg.success(`预约已完成！`);
        this.getData();
      },
      error => {
        this.loading = false;
      },
    );
  }

  cancel(item) {
    this.modalSrv.create({
      nzTitle: '确认删除',
      nzContent: '确认要删除该条记录吗？',
      nzOnOk: () => {
        this.loading = true;
        this.srv.cancel(item).subscribe(
          resp => {
            if (resp['data']) this.msg.success(`预约成功取消！`);
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
