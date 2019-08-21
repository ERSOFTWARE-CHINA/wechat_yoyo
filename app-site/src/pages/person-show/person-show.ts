import { Component, OnInit } from '@angular/core';
import { ModalController,  IonicPage,NavController  } from 'ionic-angular';
import{ PersonShowDetailPage } from '../person-show-detail/person-show-detail';
import { PersonShowService } from './service';
/**
 * Generated class for the PersonShowPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-person-show',
  templateUrl: 'person-show.html',
})
export class PersonShowPage  implements OnInit  {


  characters = [
    {
      name: 'Gollum',
      quote: 'Sneaky little hobbitses!',
      image: 'assets/img/speakers/bear.jpg',
      items: [
        { type: 'bear', url: 'assets/img/speakers/bear.jpg' },
        { type: 'cheetah', url: 'assets/img/speakers/cheetah.jpg' },
        { type: 'duck', url: 'assets/img/speakers/duck.jpg' }
      ]
    }
  ]



  constructor(public modalCtrl: ModalController,
    public navCtrl: NavController,
    private srv: PersonShowService) { }


  ngOnInit() {
    
    this.getData();
  }

  getData() {
    this.srv.list().then(resp => console.log(resp))
  }

 
  /**
   * Navigate to the detail page for this item.
   */
  openItem(items: any) {
    this.navCtrl.push('PersonShowDetailPage', {
      items: items
    });
  }


  ionViewDidLoad() {
    console.log('ionViewDidLoad PersonShowPage');
  }

}
