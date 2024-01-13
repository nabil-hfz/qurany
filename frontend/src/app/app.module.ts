import { KhatmaService } from './services/khatma/khatma.service';

import { ErrorHandler, NgModule } from '@angular/core';
import { MatChipsModule } from '@angular/material/chips';

import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterOutlet } from '@angular/router';
import { FlexLayoutModule } from '@angular/flex-layout';

// import { PortfolioListComponent } from './portfolio/portfolio-grid/portfolio-grid.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
// import { SummaryPipe } from './pipes/summary.pipe';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatToolbarModule } from "@angular/material/toolbar";
import { MatButtonModule } from "@angular/material/button";
import { MatProgressBarModule } from "@angular/material/progress-bar";
// import { PortfolioDetailsComponent } from './portfolio/portfolio-details/portfolio-details.component';
import { AppRoutingModule } from './app.routes';
import { AppErrorHandler } from './common/app-error-handler';
import { HttpClientModule } from '@angular/common/http';
import { ToastrModule } from 'ngx-toastr';
import { NotFoundComponent } from './shared/not-found/not-found.component';
import { SpinnerComponent } from './shared/spinner/spinner.component';
// import { SpinnerComponent } from './shared/spinner/spinner.component';

import { MatSidenavModule } from "@angular/material/sidenav";
import { KhatmatGridComponent } from './khatmat/khatmat-grid/khatmat-grid.component';
import { KhatmaDetailsComponent } from './khatmat/khatma-details/khatma-details.component';
import { RecitersGridComponent } from './rectiers/reciters-grid/reciters-grid.component';
import { RecitersService } from './services/reciters/reciters.service';
import { ReciterDetailsComponent } from './rectiers/reciter-details/reciter-details.component';
import { NgxAudioPlayerModule } from 'ngx-audio-player';
import { RecitationsService } from './services/recitations/recitations.service';
import { RecitationsListComponent } from './recitations/recitations-list/recitations-list.component';
// import { MatListModule, MatIconModule } from '@angular/material';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { PlayerComponent } from './shared/player/player.component';
import { RecitationCardComponent } from './recitations/recitation-card/recitation-card.component';
import { KawtharunaAppBarComponent } from './shared/kawtharuna-app-bar/kawtharuna-app-bar.component';
import { TrackControlComponent } from './shared/track-control/track-control.component';
import { LibraryGridComponent } from './library/library-grid/library-grid.component';
import { LibraryService } from './services/library/library.service';

// import { ToastrModule } from "ngx-toastr";
// import { ImageSelectorComponent } from './shared/image-selector/image-selector.component';
// import { EntriesService } from './stores/portfolio/api/portfolio.service';
// import { HttpClientModule } from '@angular/common/http';
// import { NotFoundComponent } from './shared/not-found/not-found.component';
// import { PortfolioFormComponent } from './portfolio/portfolio-form/portfolio-form.component';
// import { AppErrorHandler } from './common/app-error-handler';
// import { AbsoluteUrlPipe } from './pipes/url.pipe';



@NgModule({
  declarations: [
    SpinnerComponent,
    NotFoundComponent,
    AppComponent,

    //
    KhatmatGridComponent,
    KhatmaDetailsComponent,
    RecitersGridComponent,
    ReciterDetailsComponent,
    RecitationsListComponent,
    RecitationCardComponent,

    // Library
    LibraryGridComponent,
    // SharedComponent
    PlayerComponent,
    KawtharunaAppBarComponent,
    TrackControlComponent,
    // PortfolioListComponent,
    // PortfolioDetailsComponent,
    // ImageSelectorComponent,
    // PortfolioFormComponent,

    //Pipes
    // SummaryPipe,
    // AbsoluteUrlPipe,
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,

    CommonModule,
    RouterOutlet,
    MatToolbarModule,
    MatListModule,
    MatIconModule,

    FormsModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatInputModule,
    MatCardModule,
    MatGridListModule,
    MatProgressBarModule,
    MatChipsModule,
    ToastrModule.forRoot({ preventDuplicates: true }),
    // RouterModule.forRoot(routes),

    MatSidenavModule,
    MatButtonModule,
    FlexLayoutModule,
    HttpClientModule,
    //
    NgxAudioPlayerModule,
    AppRoutingModule,

  ],
  providers: [
    // EntriesService,
    KhatmaService,
    RecitersService,
    RecitationsService,
    LibraryService,
    // RecitationsService
    {
      provide: ErrorHandler,
      useClass: AppErrorHandler,
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
  title = 'hello-world';
}