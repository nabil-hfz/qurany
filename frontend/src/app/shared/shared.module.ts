import { NgModule } from "@angular/core";

import { MenuItems } from "./menu-items/menu-items";
import {
  AccordionAnchorDirective,
  AccordionLinkDirective,
  AccordionDirective,
  PermissionsAccessDirective,
  ScrollableDirective,
} from "./accordion";

// import { ScrollableDirective } from "./directives/scrollabel.directive";
import { ConfirmDialogComponent } from "./components/confirm-dialog/confirm-dialog.component";
// import { PermissionsAccessDirective } from "./directives/permissions-access.directive";
import { ClearSubscriptionsComponent } from "./components/clear-subscriptions/clear-subscriptions.component";
import { NotificationComponent } from './components/notification/notification.component';
// import { AccessObjValuePipe } from './pipes/access-obj-value.pipe';
import { AskDialogComponent } from './components/ask-dialog/ask-dialog.component';
// import { UploadProfileImageComponent } from "../my-profile/upload-profile-image/upload-profile-image.component";

@NgModule({
  declarations: [
    // AccordionAnchorDirective,
    // AccordionLinkDirective,
    // AccordionDirective,
    // //
    // PermissionsAccessDirective,
    // ScrollableDirective,
    // UploadSingleMediaComponent,
    // UploadProfileImageComponent,
    // ScrollableDirective,
    ConfirmDialogComponent,
    // PermissionsAccessDirective,
    ClearSubscriptionsComponent,
    NotificationComponent,
    // AccessObjValuePipe,
    AskDialogComponent,
  ],
  exports: [
    // AccordionAnchorDirective,
    // AccordionLinkDirective,
    // AccordionDirective,
    // //
    // PermissionsAccessDirective,
    // ScrollableDirective,
    // UploadSingleMediaComponent,
    // UploadProfileImageComponent,
    // ScrollableDirective,
    // PermissionsAccessDirective,
    ClearSubscriptionsComponent,
    NotificationComponent,
    // AccessObjValuePipe
  ],
  imports: [],
  providers: [MenuItems],
})
export class SharedModule {}
