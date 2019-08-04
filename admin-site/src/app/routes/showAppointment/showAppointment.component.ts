import { Component, OnInit, OnDestroy } from '@angular/core';
import { ShowAppointmentService } from './showAppointment.service';
import { getNowFormatDate, getNowFormatTime } from '../../utils/datehandler';

@Component({
  templateUrl: './showAppointment.component.html',
})
export class ShowAppointmentComponent implements OnInit {
  q = {
    show_appointments: true,
    status: '0',
    date: getNowFormatDate(),
    time: getNowFormatTime(),
    page_index: 1,
    page_size: 20,
  };

  data: any = [];
  private timer;
  constructor(private srv: ShowAppointmentService) {
    this.timer = setInterval(() => {
      //设置定时刷新事件，每隔5秒刷新
      this.getData();
    }, 5000);
  }

  ngOnInit() {
    // while (true) {
    //   this.sleep(5000);
    this.getData();
    // }
  }

  getData() {
    this.srv.listOnePage(this.q).subscribe(resp => (this.data = resp['data']));
  }

  ngOnDestroy() {
    if (this.timer) {
      clearInterval(this.timer);
    }
  }

  refreshData() {
    while (true) {}
  }

  sleep(delay) {
    const start = new Date().getTime();
    while (new Date().getTime() < start + delay);
  }
}
