// import { bootstrapApplication } from '@angular/platform-browser';
// import { appConfig } from './app/app.config';
// import { AppComponent } from './app/app.component';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { AppModule } from './app/app.module';

// bootstrapApplication(AppComponent, appConfig)
//   .catch((err) => console.error(err));

platformBrowserDynamic()
  .bootstrapModule(AppModule)
  .catch(err => console.error(err));


// shared
// services

// recitations test + documentation 
// reciters test + documentation 
// services test + documentation 
// common test + documentation 



// ng test --include="src/app/shared/*/**.spec.ts"
// ng test --include="src/app/services/*/**.spec.ts"