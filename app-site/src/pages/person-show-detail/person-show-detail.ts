import { Component } from '@angular/core';
import { IonicPage,Platform,ViewController, NavParams,NavController } from 'ionic-angular';
import { ModalController } from 'ionic-angular';
import { GalleryModal } from 'ionic-gallery-modal';
/**
 * Generated class for the PersonShowDetailPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */


@IonicPage()
@Component({
  selector: 'page-person-show-detail',
  templateUrl: 'person-show-detail.html',
})
export class PersonShowDetailPage {
  items: any;
  character;

  constructor(public navCtrl: NavController, navParams: NavParams,private  modalCtrl:ModalController) {
    this.items = navParams.get('items') ;
    console.log("显示this.items的内容");
    console.log(this.items);
  }


  private openModal() {
    let modal = this.modalCtrl.create(GalleryModal, {
      photos: this.items,
      initialSlide: 1, // The second image
    });
    modal.present();
  }

 
  /*
    var characters = [
      {
        name: 'Gollum',
        quote: 'Sneaky little hobbitses!',
        image: 'assets/img/avatar-gollum.jpg',
        items: [
          { title: 'Race', note: 'Hobbit' },
          { title: 'Culture', note: 'River Folk' },
          { title: 'Alter Ego', note: 'Smeagol' }
        ]
      },
      {
        name: 'Frodo',
        quote: 'Go back, Sam! I\'m going to Mordor alone!',
        image: 'assets/img/avatar-frodo.jpg',
        items: [
          { title: 'Race', note: 'Hobbit' },
          { title: 'Culture', note: 'Shire Folk' },
          { title: 'Weapon', note: 'Sting' }
        ]
      },
      {
        name: 'Samwise Gamgee',
        quote: 'What we need is a few good taters.',
        image: 'assets/img/avatar-samwise.jpg',
        items: [
          { title: 'Race', note: 'Hobbit' },
          { title: 'Culture', note: 'Shire Folk' },
          { title: 'Nickname', note: 'Sam' }
        ]
      }
    ];
    this.character = characters[this.params.get('charNum')];
  }

  dismiss() {
    this.viewCtrl.dismiss();
  */

/*
showimage(){
  let modal = this.modalCtrl.create(GalleryModal, {
    photos: photos,
    initialSlide: index
  });
  modal.present();
}
*/


}
