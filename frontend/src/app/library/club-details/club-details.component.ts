// import { Component, OnInit } from "@angular/core";
// import { FormControl, FormGroup, Validators } from "@angular/forms";
// import { MatDialog } from "@angular/material/dialog";
// import { ActivatedRoute, Router } from "@angular/router";
// // import { Actions, Select, Store } from "@ngxs/store";
// import { ToastrService } from "ngx-toastr";
// import { Observable, of } from "rxjs";
// import { map, switchMap, take, takeUntil, withLatestFrom } from "rxjs/operators";
// // import { Club, statusLables } from "src/app/models/club.model";
// // import { PodcastCategory } from "src/app/models/podcast-category.model";
// // import { SystemUser } from "src/app/models/user-system.model";
// // import { AskDialogComponent } from "src/app/shared/components/ask-dialog/ask-dialog.component";
// // import { ConfirmDialogComponent } from "src/app/shared/components/confirm-dialog/confirm-dialog.component";
// // import { NotificationComponent } from "src/app/shared/components/notification/notification.component";
// // import { ROUTES } from "src/app/shared/consts/routes";
// // import { checkFormValidaty } from "src/app/shared/utils/form-validaty";
// import {
//   Auth,
//   AuthSelector,
//   ClubsActions,
//   ClubsSelector,
//   PodcastCategoriesAction,
//   PodcastCategoriesSelector,
// } from "src/app/store";

// @Component({
//   selector: "app-club-details",
//   templateUrl: "./club-details.component.html",
//   styleUrls: ["./club-details.component.scss"],
// })
// export class ClubDetailsComponent
//   extends NotificationComponent
//   implements OnInit {
//   pageTitle = "Add new club";
//   // isCopied: boolean = false;
//   // statuses = statusLables;
//   clubId!: string | null;
//   // createdBy!: SystemUser;
//   // categories!: PodcastCategory[];

//   // @Select(ClubsSelector.selectedClub)
//   // selectedClub$!: Observable<Club>;
//   // @Select(ClubsSelector.loaded) loaded$!: Observable<boolean>;
//   // @Select(AuthSelector.user) createdBy$!: Observable<SystemUser>;
//   // @Select(PodcastCategoriesSelector.podcastCategories) categories$!: Observable<
//   //   PodcastCategory[]
//   // >;
//   // @Select(ClubsSelector.copiedClub) copiedClub$?: Observable<Club>;
//   form!: FormGroup;

//   isDisabled$!: Observable<boolean>;

//   errorActions = [
//     ClubsActions.AddClub,
//     ClubsActions.EditClub,
//     ClubsActions.CopyAction,
//   ];
//   successActions = [
//     ClubsActions.AddClub,
//     ClubsActions.EditClub,
//     ClubsActions.CopyAction,
//   ];

//   get imageCtrl() {
//     return this.form.get("image") as FormControl;
//   }

//   get nameEnCtrl() {
//     return this.form.get("name.en") as FormControl;
//   }

//   get descriptionEnCtrl() {
//     return this.form.get("description.en") as FormControl;
//   }

//   get statusCtrl() {
//     return this.form.get("status") as FormControl;
//   }

//   get categoryCtrl() {
//     return this.form.get("category") as FormControl;
//   }

//   get clubFeesCtrl() {
//     return this.form.get("clubFees") as FormControl;
//   }

//   get autoJoinedCtrl() {
//     return this.form.get("autoJoined") as FormControl;
//   }

//   constructor(
//     private route: ActivatedRoute,
//     private router: Router,
//     private store: Store,
//     public toaster: ToastrService,
//     public actions$: Actions,
//     private dialog: MatDialog
//   ) {
//     super(actions$, toaster);
//   }

//   ngOnInit(): void {
//     this.clubId = this.route.snapshot.paramMap.get("id");
//     this.initForm();
//     if (this.clubId) {
//       this.setClub();
//       this.pageTitle = "Edit Club";
//     }

//     this.excute();
//     this.isDisabled$ = checkFormValidaty(this.form, this.loaded$);
//     this.getMyProfile();
//     this.getCategories();
//   }

//   getCategories() {
//     this.store
//       .dispatch(new PodcastCategoriesAction.GetAllPodcastCategories())
//       .pipe(
//         takeUntil(this.destroy$),
//         withLatestFrom(this.categories$),
//         map(([_, data]) => data)
//       )
//       .subscribe((res) => (this.categories = res));
//   }

//   getMyProfile() {
//     this.store
//       .dispatch(new Auth.GetMyProfile())
//       .pipe(
//         takeUntil(this.destroy$),
//         withLatestFrom(this.createdBy$),
//         map(([_, user]) => {

//           return user})
//       )
//       .subscribe((res) => {
//         return (this.createdBy = res)});
//   }

//   setClub() {
//     this.store
//       .dispatch(new ClubsActions.GetClub(this.clubId!))
//       .pipe(
//         withLatestFrom(this.selectedClub$),
//         map(([_, data]) => {
//           return data;
//         }),
//         takeUntil(this.destroy$)
//       )
//       .subscribe((club) => {
//         this.form.patchValue({
//           ...club,
//           category: club?.category?.id, 
//           image: club?.image?.id
//         });
//       });
//   }

//   submit() {
//     this.clubId ? this.update() : this.create();
//   }

//   setImage(eve: any) {
//     this.imageCtrl.setValue(eve);
//   }

//   create() {
//     this.defaultErrorMsg = "Club created failed";
//     this.defaultSuccessMsg = "Club created successfully";

//     this.store
//       .dispatch(new ClubsActions.AddClub({ ...this.prepareData(true) }))
//       .pipe(
//         withLatestFrom(this.selectedClub$),
//         map(([_, data]) => data),
//         takeUntil(this.destroy$)
//       )
//       .subscribe((res) => {
//         this.router.navigate(["../", ROUTES.EDIT_CLUB, res?.id], {
//           relativeTo: this.route,
//         });
//       });
//   }

//   update() {
//     this.defaultErrorMsg = "Club updated failed";
//     this.defaultSuccessMsg = "Club updated successfully";
//     this.store.dispatch(
//       new ClubsActions.EditClub({ ...this.prepareData(), id: this.clubId })
//     );
//   }

//   initForm() {
//     this.form = new FormGroup({
//       name: new FormGroup({
//         en: new FormControl(null, Validators.required),
//         ar: new FormControl(""),
//       }),
//       description: new FormGroup({
//         en: new FormControl(null, Validators.required),
//         ar: new FormControl(""),
//       }),
//       status: new FormControl(null, Validators.required),
//       category: new FormControl(null, Validators.required),
//       skill: new FormControl(6),
//       image: new FormControl(null),
//       clubFees: new FormControl(null, [Validators.required, Validators.min(0)]),
//       autoJoined: new FormControl(true, [Validators.required]),
//     });
//   }

//   prepareData(isAdding: boolean = false) {
//     const category = this.categories.find(
//       (cat) => cat.id === this.categoryCtrl.value
//     );
//     let value = { ...this.form.value };
//     if (isAdding) {
//       const { email, firstName, lastName, image, ...rest } = this.createdBy;
//       value.createdBy = {
//         id: rest?.id ?? rest?.uid ?? null,
//         email,
//         image: image ?? '', 
//         name: `${firstName} ${lastName}`,
//       };
//     } else {
//       this.selectedClub$.pipe(take(1)).subscribe(e => {
//         value.createdBy = e.createdBy;
//       })
//     }
//     value.nameCopy = {
//       en: value.name?.en?.toLowerCase() ?? "",
//       ar: value.name?.ar?.toLowerCase() ?? ""
//     }
//     value.createdDate = new Date();
//     value.category = {
//       id: category?.id,
//       name: category?.name,
//     };
//     return value;
//   }

//   copy() {
//     this.defaultErrorMsg = "Club copied failed";
//     this.defaultSuccessMsg = "Club copied successfully";

//     this.dialog
//       .open(ConfirmDialogComponent, {
//         width: "500px",
//         disableClose: true,
//         data: {
//           message: `Are you sure you want to copy this club?`,
//         },
//       })
//       .afterClosed()
//       .pipe(
//         switchMap((res) => {
//           if (!res?.confirmed) return of(null);
//           const dispatch$ = this.store
//             .dispatch(
//               new ClubsActions.CopyAction({
//                 ...this.prepareData(),
//                 id: this.clubId,
//               })
//             )
//             .pipe(
//               withLatestFrom(this.selectedClub$),
//               map(([_, data]) => data)
//             );


//           return dispatch$
//         })
//       )
//       .subscribe((res) => {
//         if (res) {
//           this.router.navigate(["../../"], {
//             relativeTo: this.route,
//           });
//         }
//       });
//   }

//   askToNavigate() {
//     return this.dialog
//       .open(AskDialogComponent, {
//         width: "500px",
//         disableClose: true,
//         data: {
//           message: `Are you want to navigate to copied club?`,
//         },
//       })
//       .afterClosed()
//   }
// }
