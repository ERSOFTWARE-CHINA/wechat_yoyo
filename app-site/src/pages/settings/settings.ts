import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { TranslateService } from '@ngx-translate/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { Platform } from 'ionic-angular';

import { Settings } from '../../providers';
import { SettingsService } from './service';

/**
 * The Settings page is a simple form that syncs with a Settings provider
 * to enable the user to customize settings for the app.
 *
 */
@IonicPage()
@Component({
  selector: 'page-settings',
  templateUrl: 'settings.html'
})
export class SettingsPage implements OnInit {
  content: string = "account";
  accounts: any = {card_name: "", remainder: null};
  orders: any[] = [];
  appointments: any[] = [];
  records: any[] =[];



  constructor(public navCtrl: NavController,
    public settings: Settings,
    public formBuilder: FormBuilder,
    public navParams: NavParams,
    private srv: SettingsService,
    public translate: TranslateService) {
      
  }

  ngOnInit(){
    this.getData();
  }

  ionViewDidEnter(){
    this.getData();
  }

  getData(){
    this.getAccountData();
    this.getAppointmentData();
    this.getOrderData();
    this.getRecordData();
  }

  getAccountData(){
    this.srv.getAccounts().then(resp => this.accounts = resp.data).then(_=>console.log(this.accounts));
  }

  getOrderData(){
    this.srv.getOrders().then(resp => this.orders = resp.data).then(_=>console.log(this.orders));

  }

  getAppointmentData(){
    this.srv.getAppointments().then(resp => this.appointments = resp.data).then(_=>console.log(this.appointments));
  }

  getRecordData(){
    this.srv.getRecords().then(resp => this.records = resp.data).then(_=>console.log(this.records));
  }

}
