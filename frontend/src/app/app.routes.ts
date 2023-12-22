import { Routes } from '@angular/router';
import { KhatmatGridComponent } from './khatmat/khatmat-grid/khatmat-grid.component';
import { KhatmaDetailsComponent } from './khatmat/khatma-details/khatma-details.component';
import { NotFoundComponent } from './shared/not-found/not-found.component';
import { RecitersGridComponent } from './rectiers/reciters-grid/reciters-grid.component';

export const routes: Routes = [
    // Reciter Module
    { path: '', component: KhatmatGridComponent },

    // { path: 'khatmat', component: KhatmatGridComponent },
    { path: 'reciters', component: RecitersGridComponent },

    // Khatma Module
    // { path: 'khatmat-grid/:reciterId/:reciterName', component: KhatmatGridComponent },
    { path: 'khatma-details/:khatmaId/:khatmaName', component: KhatmaDetailsComponent },
    { path: '**', component: NotFoundComponent },

];
