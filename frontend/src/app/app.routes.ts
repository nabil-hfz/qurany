import { RouterModule, Routes } from '@angular/router';
import { KhatmatGridComponent } from './khatmat/khatmat-grid/khatmat-grid.component';
import { KhatmaDetailsComponent } from './khatmat/khatma-details/khatma-details.component';
import { NotFoundComponent } from './shared/not-found/not-found.component';
import { RecitersGridComponent } from './rectiers/reciters-grid/reciters-grid.component';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { LibraryGridComponent } from './library/library-grid/library-grid.component';
import { PrivacyPolicyComponent } from './privacy-policy/privacy-policy.component';
import { FileFormComponent } from './library/file-form/file-form.component';

const routes: Routes = [
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

];



@NgModule({
    imports: [CommonModule, RouterModule.forRoot(routes, { useHash: true })],
    exports: [RouterModule],
    declarations: [],
})
export class AppRoutingModule { }