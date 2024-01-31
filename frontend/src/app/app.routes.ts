import { RouterModule, Routes } from '@angular/router';
import { KhatmatGridComponent } from './khatmat/khatmat-grid/khatmat-grid.component';
import { KhatmaDetailsComponent } from './khatmat/khatma-details/khatma-details.component';
import { NotFoundComponent } from './shared/components/not-found/not-found.component';
import { RecitersGridComponent } from './rectiers/reciters-grid/reciters-grid.component';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { LibraryGridComponent } from './library/library-grid/library-grid.component';
import { PrivacyPolicyComponent } from './privacy-policy/privacy-policy.component';
import { FileFormComponent } from './library/file-form/file-form.component';
import { FullComponent } from './shared/components/layouts/full/full.component';

const routes: Routes = [

  {
    path: "",
    component: FullComponent,
    // canActivate: [AuthGuard],
    children: [
      //   {
      //     path: "my-profile",
      //     canLoad: [AuthGuard],
      //     loadChildren: () =>
      //       import("./my-profile/my-profile.module").then(
      //         (m) => m.MyProfileModule
      //       ),
      //   },
      //   {
      //     path: "dashboard",
      //     canLoad: [AuthGuard],
      //     loadChildren: () =>
      //       import("./dashboard/dashboard.module").then((m) => m.DashboardModule),
      //   },
      //   {
      //     path: ROUTES.USERS,
      //     canLoad: [AuthGuard],
      //     loadChildren: () =>
      //       import("./mobile-users/mobile-users.module").then(
      //         (m) => m.MobileUsersModule
      //       ),
      //   },
      //   {
      //     path: ROUTES.POSTS,
      //     canLoad: [AuthGuard],
      //     loadChildren: () =>
      //       import("./posts/posts.module").then((m) => m.PostsModule),
      //   },
      // Reciter Module
      { path: '', redirectTo: '/khatma', pathMatch: 'full' },

      // { path: 'khatmat', component: KhatmatGridComponent },
      { path: 'reciters', component: RecitersGridComponent },

      // Khatma Module
      // { path: 'khatmat-grid/:reciterId/:reciterName', component: KhatmatGridComponent },
      { path: 'khatma', component: KhatmatGridComponent },
      { path: 'khatma-details/:khatmaId/:khatmaName', component: KhatmaDetailsComponent },

      // Library Module
      { path: 'library', component: LibraryGridComponent },
      { path: 'library-form', component: FileFormComponent },

      { path: 'privacy-policy', component: PrivacyPolicyComponent },

      { path: '**', component: NotFoundComponent },
      {
        path: "",
        redirectTo: "/dashboard",
        pathMatch: "full",
      },
    ],
  },



];



@NgModule({
  imports: [CommonModule, RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule],
  declarations: [],
})
export class AppRoutingModule { }