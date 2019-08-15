import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { PostComponent } from './post.component';
import { PostListComponent } from './list/list.component';
import { PostFormComponent } from './form/form.component';

const routes: Routes = [
  {
    path: '',
    component: PostComponent,
    children: [
      { path: '', redirectTo: 'page', pathMatch: 'full' },
      { path: 'page', component: PostListComponent },
      { path: 'form', component: PostFormComponent },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class PostRoutingModule { }
