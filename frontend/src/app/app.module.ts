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
import { MatMenuModule } from '@angular/material/menu';

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
import { NotFoundComponent } from './shared/components/not-found/not-found.component';
import { SpinnerComponent } from './shared/components/spinner/spinner.component';
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
import { PlayerComponent } from './shared/components/player/player.component';
import { RecitationCardComponent } from './recitations/recitation-card/recitation-card.component';
import { KawtharunaAppBarComponent } from './shared/components/kawtharuna-app-bar/kawtharuna-app-bar.component';
import { TrackControlComponent } from './shared/components/track-control/track-control.component';
import { PrivacyPolicyComponent } from './privacy-policy/privacy-policy.component';
import { LibraryGridComponent } from './library/library-grid/library-grid.component';
import { LibraryService } from './services/library/library.service';
import { FileDetailsComponent } from './library/file-details/file-details.component';
import { SafeUrlPipe } from './shared/pipes/safe-url.pipe';
import { NgxDocViewerModule } from 'ngx-doc-viewer';
import { FileFormComponent } from './library/file-form/file-form.component';
import { MatOptionModule } from '@angular/material/core';
import { MatSelectModule } from '@angular/material/select';
import { FullComponent } from './shared/components/layouts/full/full.component';
import { DemoMaterialModule } from './demo-material-module';
import { AppHeaderComponent } from './shared/components/layouts/full/header/header.component';
import { AppSidebarComponent } from './shared/components/layouts/full/sidebar/sidebar.component';
import { SharedModule } from './shared/shared.module';
import { AccordionAnchorDirective, AccordionDirective, AccordionLinkDirective, PermissionsAccessDirective, ScrollableDirective } from './shared/accordion';

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

    // SharedComponent
    PlayerComponent,
    KawtharunaAppBarComponent,
    TrackControlComponent,
    PrivacyPolicyComponent,
    LibraryGridComponent,
    FileDetailsComponent,
    FileFormComponent,
    FullComponent,
    AppHeaderComponent,

    AppSidebarComponent,
    // PortfolioListComponent,
    // PortfolioDetailsComponent,
    // ImageSelectorComponent,
    // PortfolioFormComponent,

    //Pipes
    // SummaryPipe,
    // AbsoluteUrlPipe,
    SafeUrlPipe,

    AccordionAnchorDirective,
    AccordionLinkDirective,
    AccordionDirective,
    //
    PermissionsAccessDirective,
    ScrollableDirective,

  ],
  imports: [
    DemoMaterialModule,
    
    BrowserModule,
    BrowserAnimationsModule,
    CommonModule,
    RouterOutlet,
    HttpClientModule,
    ToastrModule.forRoot({ preventDuplicates: true }),
    // RouterModule.forRoot(routes),
    AppRoutingModule,

    //
    NgxAudioPlayerModule,
    NgxDocViewerModule,

    // SharedModule,

    

  ],
  providers: [
    KhatmaService,
    RecitersService,
    RecitationsService,
    LibraryService,
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