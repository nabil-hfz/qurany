import { NgModule } from "@angular/core";

import { MenuItems } from "./menu-items/menu-items";
import {
  AccordionAnchorDirective,
  AccordionLinkDirective,
  AccordionDirective,
  PermissionsAccessDirective,
  ScrollableDirective,
} from "./accordion";
// import { UploadSingleMediaComponent } from "./upload-single-media/upload-single-media.component";
import { DemoMaterialModule } from "../demo-material-module";
import { CommonModule } from "@angular/common";
// import { ScrollableDirective } from "./directives/scrollabel.directive";
import { ConfirmDialogComponent } from "./components/confirm-dialog/confirm-dialog.component";
// import { PermissionsAccessDirective } from "./directives/permissions-access.directive";
import { TableComponent } from "./components/table/table.component";
import { ClearSubscriptionsComponent } from "./components/clear-subscriptions/clear-subscriptions.component";
import { NotificationComponent } from './components/notification/notification.component';
// import { AccessObjValuePipe } from './pipes/access-obj-value.pipe';
import { CopySettingComponent } from './components/copy-setting/copy-setting.component';
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
    TableComponent,
    ClearSubscriptionsComponent,
    NotificationComponent,
    // AccessObjValuePipe,
    CopySettingComponent,
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
    TableComponent,
    ClearSubscriptionsComponent,
    NotificationComponent,
    // AccessObjValuePipe
  ],
  imports: [DemoMaterialModule, CommonModule],
  providers: [MenuItems],
})
export class SharedModule {}
