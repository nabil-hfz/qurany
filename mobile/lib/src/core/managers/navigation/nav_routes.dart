class Routes {
  Routes._();

  //static variables
  static const String root = '/';
  static const String splash = '/splash';

  //static variables
  // static const String locationPickerBottomSheet =
  //     'lib/core/widgets/bottom_sheet/location_picker_bottom_sheet_widget.dart';

  /// main pages
  static const String mainRootPage = '/main_root_page';
  static const String home = '/home';

  static const String searchPage = '/search';
  static const String filterPage = '/filter';

  // static const String cataloguePage = '/catalogue';
  // static const String catalogueKindPage = '/catalogue/:kind(packages|services)';
  // static const String cataloguePackagesPage = '/catalogue/packages';
  // static const String catalogueServicesPage = '/catalogue/services';

  /// Auth Pages
  /// Auth Pages
  static const String signUpPage = '/sign-up';
  static const String confirmAuthInfoPage = '/ConfirmAuthInfoPage';
  static const String forgetPasswordPage = '/ForgetPasswordPage';
  static const String resetPasswordPage = '/reset-password';
  static const String logInPage = '/log-in';
  static const String profilePage = '/profile';
  static const String myFavoritesPage = '/my-favorites';
  static const String editProfilePage = '/edit-profile';
  static const String introductionPage = '/introduction';

  static const String notificationsPage = '/notifications';
  static const String notificationsSettingsPage = '/notifications-settings';
  static const String feedbackPage = '/feedback';
  static const String settingsAccountPage = '/settings-account';
  static const String deleteAccountPage = '/delete-account';
  static const String settingsPage = '/settings';
  static const String contactUsPage = '/contact-us';
  static const String changePasswordPage = '/change-password';
  static const String changeEmailPage = '/change-email';

  /// Gallery Folder Images
  static const String galleryFullViewWidget = '/gallery-view';
  static const String galleryFolderImagesListPage = '/gallery-folder-images';

  /// Category pages
  static const String tagsPage = '/tags';
  static const String addTagPage = '/add-tag';

  /// Service pages
  static const String servicesPage = '/services';
  static const String serviceDetailPage = '/service-details';

  /// Package pages
  static const String packagesPage = '/packages';
  static const String packageDetails = '/package-details';

  /// Booking pages
  static const String bookingsListPage = '/bookings';
  static const String addBookingPage = '/add-booking';
  static const String bookingDetailsPage = '/booking-details';
  static const String bookingCheckOutPage = '/booking-checkout';
  static const String bookingSuccessfulPage = '/booking-successful';

  /// Cart pages
  static const String cartsPage = '/carts-list';

  /// Salon pages
  static const String salonsPage = '/salons';
  static const String salonDetails = '/salon-details';

  static const String salonDetailsUrl = '/api/app/client-salon/:id';

  /// Staff pages
  static const String staffListPage = '/staffs';

  /// Offer Pages
  static const String offersPage = '/offers';
  static const String offerDetailsPage = '/offers-details';

  /// More Pages
  static const String morePage = '/more';

  /// Main Root Pages
  static const String homePage = '/home';
  static const String cataloguePage = '/catalogue';
  static const String catalogueKindPage = '/catalogue/:kind(packages|services)';
  static const String cataloguePackagesPage = '/catalogue/packages';
  static const String catalogueServicesPage = '/catalogue/services';

  ///
  static const String termsOfUsePage = '/terms-of-use';
  static const String privacyPolicyPage = '/privacy-policy';
  static const String userDataDeletionPage = '/user-data-deletion';

// static Route? onGenerateRoute(RouteSettings settings) {
//   final args = settings.arguments as BaseNavigationArg?;
//   NavigationType type = NavigationType.scale;
//   if (args?.navigationType != null) type = args!.navigationType!;
//   if (settings.name == '/unKnowRoute') return null;
//   return PageRouteBuilder(
//     reverseTransitionDuration: const Duration(
//       milliseconds: AppDuration.shimmerAnimationDuration,
//     ),
//     transitionDuration: const Duration(
//       milliseconds: AppDuration.shimmerAnimationDuration,
//     ),
//     pageBuilder: (c, a1, a2) {
//       return getPage(settings, args?.data, a1, a2);
//     },
//     settings: settings,
//     transitionsBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child,
//     ) {
//       if (type == NavigationType.fade) {
//         return FadeThroughTransition(
//           animation: animation,
//           // fillColor: AppColors.primaryColor,
//           secondaryAnimation: secondaryAnimation,
//           child: child,
//         );
//       }
//       if (type == NavigationType.fadeScale) {
//         return FadeScaleTransition(
//           animation: animation,
//           child: child,
//         );
//       }
//       if (type == NavigationType.slideHorizontal) {
//         return SharedAxisTransition(
//           animation: animation,
//           // fillColor: AppColors.primaryColor,
//           secondaryAnimation: secondaryAnimation,
//           transitionType: SharedAxisTransitionType.horizontal,
//           child: child,
//         );
//       }
//       if (type == NavigationType.slideVertical) {
//         return SharedAxisTransition(
//           animation: animation,
//           // fillColor: AppColors.primaryColor,
//           secondaryAnimation: secondaryAnimation,
//           transitionType: SharedAxisTransitionType.vertical,
//           child: child,
//         );
//       }
//
//       /// Scale Just
//       return SharedAxisTransition(
//         animation: animation,
//         // fillColor: AppColors.primaryColor,
//         secondaryAnimation: secondaryAnimation,
//         transitionType: SharedAxisTransitionType.scaled,
//         child: child,
//       );
//     },
//   );
// }

// static Widget getPage(
//   RouteSettings settings,
//   Object? argument,
//   Animation<double> a1,
//   Animation<double> a2,
// ) {
//   switch (settings.name) {
//     // case splash:
//     //   return const SplashPage();
//     // case signUpPage:
//     //   return const SignUpPage();
//     // case verifyPage:
//     //   return VerifyPage(args: argument as VerifyArgs);
//     //
//     // case forgetPasswordPage:
//     //   return const ForgetPasswordPage();
//     // case resetPasswordPage:
//     //   return const ResetPasswordPage();
//     // case signInPage:
//     //   return const SignInPage();
//
//     // case mainRootPage:
//     //   return const MainRootPage();
//
//     // case profilePage:
//     //   return const ProfilePage();
//
//     // case editProfilePage:
//     //   return EditProfilePage(args: argument as EditProfileArgs);
//     //
//     // case galleryFolderImagesListPage:
//     //   return GalleryFolderImagesListPage(
//     //     args: argument as GalleryFolderImagesArgs,
//     //   );
//
//     // case galleryFullViewWidget:
//     //   return GalleryFullViewWidget(args: argument as ImageGalleryArgs);
//     //
//     // case addTagPage:
//     //   return AddTagPage(args: argument as AddTagArgs);
//
//     // case staffListPage:
//     //   return const StaffsListPage();
//     //
//     // case staffAddEditPage:
//     //   return StaffAddEditPage(args: argument as StaffAddEditArgs);
//
//     // case editStaffPage:
//     //   return EditStaffPage(args: argument as StaffAddEditArgs);
//
//     // case notificationsPage:
//     //   return const NotificationsPage();
//
//     // case notificationsSettingsPage:
//     //   return const NotificationsSettingsPage();
//
//     // case settingsPage:
//     //   return const SettingsPage();
//
//     // case changePasswordPage:
//     //   return const ChangePasswordPage();
//
//     // case serviceFormPage:
//     //   return ServiceDetailPage(args: argument as ServiceDetailArgs);
//
//     // case serviceDetailPage:
//     //   return ServiceDetailsPage(args: argument as ServiceDetailsArgs);
//
//     // case packagesPage:
//     //   return const PackagesPage();
//
//     // case packageDetails:
//     //   return PackageDetails(args: argument as PackageDetailsArgs);
//
//     // case servicesPage:
//     //   return ServicesPage(args: argument as ServiceListArgs);
//
//     // case packageAddEditPage:
//     //   return PackageAddEditPage(args: argument as PackageAddEditArgs);
//     // case locationPickerBottomSheet:
//     //   return const LocationPickerBottomSheet();
//   }
//
//   return const Scaffold(
//     backgroundColor: AppColors.white,
//     body: Center(
//       child: Text('Page not found'),
//     ),
//   );
// }
}
