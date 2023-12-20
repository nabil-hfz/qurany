
import { ErrorHandler, NgModule } from '@angular/core';

import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule, RouterOutlet } from '@angular/router';
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
import { routes } from './app.routes';
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
    KhatmatGridComponent,
    KhatmaDetailsComponent,
    RecitersGridComponent,
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

    FormsModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatInputModule,
    MatCardModule,
    MatGridListModule,
    MatProgressBarModule,
    ToastrModule.forRoot({ preventDuplicates: true }),
    RouterModule.forRoot(routes),
    MatSidenavModule,
    MatButtonModule,
    FlexLayoutModule,
    HttpClientModule,
  ],
  providers: [
    // EntriesService,
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
