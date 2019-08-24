import { Component, OnInit } from '@angular/core';
import { ModalController,  IonicPage,NavController  } from 'ionic-angular';
import { Platform, NavParams, ViewController } from 'ionic-angular';
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
  templateUrl: 'person-show.html'
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
      console.log(this.posts)
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

  addGood(item) {
    this.srv.good(item).then(resp => item.good = item.good + 1);
  }

  openCommentModal(id){
    console.log("######## opening modal ########")
    let commentModal = this.modalCtrl.create( CommentModalPage, {post_id: id });
    commentModal.present();
  }
}

// @Component({
//   template: `<ion-header>
//   <ion-toolbar>
//     <ion-title>
//       Description
//     </ion-title>
//     <ion-buttons start>
//       <button ion-button (click)="dismiss()">
//         <span ion-text color="primary" showWhen="ios">Cancel</span>
//         <ion-icon name="md-close" showWhen="android, windows"></ion-icon>
//       </button>
//     </ion-buttons>
//   </ion-toolbar>
// </ion-header>

// <ion-content>
//   <ion-list>
//       <ion-item *ngFor="let item of comments">
        
//         <ion-note item-end>
//           {{item.content}}
//         </ion-note>
//       </ion-item>
//   </ion-list>
// </ion-content>`
// })
// export class CommentModalPage {
//   comments;
//   post_id;

//   constructor(
//     public platform: Platform,
//     public params: NavParams,
//     public viewCtrl: ViewController,
//     private srv: PersonShowService
//   ) {
//     this.post_id = this.params.get('post_id');
//     this.getData();
//   }

//   getData() {
//     this.srv.getComments(this.post_id).then(resp => this.comments = resp["data"])
//   }

//   dismiss() {
//     this.viewCtrl.dismiss();
//   }
// }
