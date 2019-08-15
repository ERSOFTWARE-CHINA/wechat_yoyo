import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SharedModule } from '@shared/shared.module';

import { PostRoutingModule } from './post-routing.module';

import { PostComponent } from './post.component';
import { PostListComponent } from './list/list.component';
import { PostFormComponent } from './form/form.component';
import { PostService } from './service/post.service';

@NgModule({
  imports: [SharedModule, PostRoutingModule],
  declarations: [PostComponent, PostListComponent, PostFormComponent],
  providers: [
    PostService,
    // ConfirmationService
  ],
})
export class PostModule { }
