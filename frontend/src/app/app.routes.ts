import { AuthGuard } from './shared/services/auth.guard';
import { RouterModule, Routes } from '@angular/router';
import { KhatmatGridComponent } from './khatmat/khatmat-grid/khatmat-grid.component';
import { KhatmaDetailsComponent } from './khatmat/khatma-details/khatma-details.component';
import { NotFoundComponent } from './shared/components/not-found/not-found.component';
import { RecitersGridComponent } from './rectiers/reciters-grid/reciters-grid.component';
import { NgModule } from '@angular/core';
import { LibraryGridComponent } from './library/library-grid/library-grid.component';
import { PrivacyPolicyComponent } from './privacy-policy/privacy-policy.component';
import { FileFormComponent } from './library/file-form/file-form.component';
import { FullComponent } from './shared/components/layouts/full/full.component';

const routes: Routes = [

  // {
  //   path: "",
  //   component: FullComponent,

  //   // canActivate: [AuthGuard],
  //   canActivate: [],
  //   children: [
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
      { path: 'file-form', component: FileFormComponent, canActivate: [AuthGuard], },

      { path: '**', component: NotFoundComponent },

  //   ],
  // },

  // { path: '', redirectTo: '/khatma', pathMatch: 'full' },
];



@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: true })],
  exports: [RouterModule],
  declarations: [],
})
export class AppRoutingModule { }