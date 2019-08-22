import { Component, OnInit } from '@angular/core';
import { ModalController,  IonicPage,NavController  } from 'ionic-angular';
import { PersonShowService } from './service';
import { GalleryModal } from 'ionic-gallery-modal';
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

  posts: any[] = []
  pics: any[] = []

  constructor(public modalCtrl: ModalController,
    public navCtrl: NavController,
    private srv: PersonShowService) { }


  ngOnInit() {
    this.getData();
  }

  getData() {
    this.srv.list().then(resp => {
      this.posts = resp["data"];
    })
  }

  // 预览图片，打开modal
  openItem(item: any) {
    this.pics = item.post_images;
    this.openModal();
  }

  openModal() {
    let modal = this.modalCtrl.create(GalleryModal, {
      photos: this.pics,
      initialSlide: 0, // The second image
    });
    modal.present();
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad PersonShowPage');
  }

}
