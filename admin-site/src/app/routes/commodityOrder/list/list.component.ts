import { Component, OnInit, ViewChild, TemplateRef, ChangeDetectionStrategy, ChangeDetectorRef } from '@angular/core';
import { Router } from '@angular/router';
import { NzMessageService, NzModalService } from 'ng-zorro-antd';
import { _HttpClient } from '@delon/theme';
import { tap, map } from 'rxjs/operators';

import { CommodityOrderService } from '../service/commodityOrder.service';

@Component({
  templateUrl: './list.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class CommodityOrderListComponent implements OnInit {
  title = '订单管理';
  total = 0;
  q: any = {
    pi: 1,
    ps: 10,
    sort_field: 'date',
    sort_direction: 'desc',
    ono: null,
    status: null,
    pay_status: null,
  };
  delivery_info: string;
  data: any[] = [];
  loading = false;

  expandForm = false;

  pay_status = [{ label: '已支付', value: true }, { label: '未支付', value: false }];
  status = [{ label: '已预定', value: 'a' }, { label: '已发货', value: 'd' }];

  constructor(
    public msg: NzMessageService,
    private modalSrv: NzModalService,
    private cdr: ChangeDetectorRef,
    private srv: CommodityOrderService,
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
    this.router.navigateByUrl('/commodityOrder/form');
  }

  delivery(tpl: TemplateRef<{}>, item) {
    this.modalSrv.create({
      nzTitle: '确认发货',
      nzContent: tpl,
      nzOnOk: () => {
        this.loading = true;
        item.delivery_info = this.delivery_info;
        this.srv.delivery(item).subscribe(
          resp => {
            if (resp['data']) this.msg.success(`发货成功！`);
            this.getData();
          },
          error => {
            this.loading = false;
          },
        );
      },
    });
  }

  // add(tpl: TemplateRef<{}>) {
  //   this.modalSrv.create({
  //     nzTitle: '新建规则',
  //     nzContent: tpl,
  //     nzOnOk: () => {
  //       this.loading = true;
  //       this.http.post('/rule', { description: this.description }).subscribe(() => this.getData());
  //     },
  //   });
  // }

  cancel(item) {
    this.modalSrv.create({
      nzTitle: '确认取消',
      nzContent: '确认要取消该订单吗？',
      nzOnOk: () => {
        this.loading = true;
        this.srv.cancel(item).subscribe(
          resp => {
            if (resp['data']) this.msg.success(`取消成功！`);
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
