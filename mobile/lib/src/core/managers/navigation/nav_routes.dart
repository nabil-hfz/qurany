//  import 'package:flutter/material.dart';
// import 'package:kawtharuna/src/core/constants/constants.dart';
// import 'package:kawtharuna/src/core/managers/managers.dart';
//
//
// class Routes {
//   Routes._();
//
//   //static variables
//   static const String splash = '/splash';
//
//   /// main pages
//   static const String mainRootPage = '/main_root_page';
//   static const String home = '/home';
//
//   /// Auth Pages
//   static const String signUpPage = '/SignUpPage';
//   static const String verifyPage = '/VerifyPage';
//   static const String forgetPasswordPage = '/ForgetPasswordPage';
//   static const String resetPasswordPage = '/ResetPasswordPage';
//   static const String signInPage = '/SignInPage';
//   static const String profilePage = '/ProfilePage';
//   static const String editProfilePage = '/EditProfilePage';
//   static const String stylistPage = '/StylistPage';
//   static const String editStylistPage = '/EditStylistPage';
//   static const String notificationsPage = '/NotificationsPage';
//   static const String notificationsSettingsPage = '/NotificationsSettingsPage';
//   static const String settingsPage = '/SettingsPage';
//   static const String changePasswordPage = '/ChangePasswordPage';
//
//   /// general widget
//   static const String galleryFullViewWidget = '/GalleryFullViewWidget';
//
//   /// Category pages
//   static const String tagsPage = '/tagsPage';
//   static const String addTagPage = '/AddTagPage';
//
//   /// Service pages
//   static const String servicesPage = '/ServicesPage';
//   static const String serviceDetailPage = '/ServiceDetailPage';
//   static const String serviceDetailsPage = '/ServiceDetailsPage';
//
//   /// Package pages
//   static const String packagesPage = '/PackagesPage';
//   static const String packageDetailPage = '/PackageDetailPage';
//
//   static Route? onGenerateRoute(RouteSettings settings) {
//     final args = settings.arguments as BaseNavigationArg?;
//     NavigationType type = NavigationType.scale;
//     if (args?.navigationType != null) type = args!.navigationType!;
//     if (settings.name == '/unKnowRoute') return null;
//     return PageRouteBuilder(
//       reverseTransitionDuration: const Duration(
//         milliseconds: AppDuration.shimmerAnimationDuration,
//       ),
//       transitionDuration: const Duration(
//         milliseconds: AppDuration.shimmerAnimationDuration,
//       ),
//       pageBuilder: (c, a1, a2) {
//         return getPage(settings, args?.data, a1, a2);
//       },
//       settings: settings,
//       transitionsBuilder: (
//         BuildContext context,
//         Animation<double> animation,
//         Animation<double> secondaryAnimation,
//         Widget child,
//       ) {
//         if (type == NavigationType.fade) {
//           return FadeThroughTransition(
//             animation: animation,
//             // fillColor: AppColors.primaryColor,
//             secondaryAnimation: secondaryAnimation,
//             child: child,
//           );
//         }
//         if (type == NavigationType.fadeScale) {
//           return FadeScaleTransition(
//             animation: animation,
//             child: child,
//           );
//         }
//         if (type == NavigationType.slideHorizontal) {
//           return SharedAxisTransition(
//             animation: animation,
//             // fillColor: AppColors.primaryColor,
//             secondaryAnimation: secondaryAnimation,
//             transitionType: SharedAxisTransitionType.horizontal,
//             child: child,
//           );
//         }
//         if (type == NavigationType.slideVertical) {
//           return SharedAxisTransition(
//             animation: animation,
//             // fillColor: AppColors.primaryColor,
//             secondaryAnimation: secondaryAnimation,
//             transitionType: SharedAxisTransitionType.vertical,
//             child: child,
//           );
//         }
//
//         /// Scale Just
//         return SharedAxisTransition(
//           animation: animation,
//           // fillColor: AppColors.primaryColor,
//           secondaryAnimation: secondaryAnimation,
//           transitionType: SharedAxisTransitionType.scaled,
//           child: child,
//         );
//       },
//     );
//   }
//
//   static Widget getPage(
//     RouteSettings settings,
//     Object? argument,
//     Animation<double> a1,
//     Animation<double> a2,
//   ) {
//     switch (settings.name) {
//       case splash:
//         return const SplashPage();
//       case signUpPage:
//         return const SignUpPage();
//       case verifyPage:
//         return VerifyPage(args: argument as VerifyArgs);
//
//       case forgetPasswordPage:
//         return const ForgetPasswordPage();
//       case resetPasswordPage:
//         return const ResetPasswordPage();
//       case signInPage:
//         return const SignInPage();
//       case home:
//         return const HomePage();
//       case mainRootPage:
//         return const MainRootPage();
//
//       case profilePage:
//         return const ProfilePage();
//
//       case editProfilePage:
//         return EditProfilePage(args: argument as EditProfileArgs);
//
//       case galleryFullViewWidget:
//         return GalleryFullViewWidget(args: argument as ImageGalleryArgs);
//
//       case addTagPage:
//         return AddTagPage(args: argument as AddTagArgs);
//
//       case stylistPage:
//         return const StylistPage();
//
//       case editStylistPage:
//         return EditStylistPage(args: argument as EditStylistArgs);
//
//       case notificationsPage:
//         return const NotificationsPage();
//
//       case notificationsSettingsPage:
//         return const NotificationsSettingsPage();
//
//       case settingsPage:
//         return const SettingsPage();
//
//       case changePasswordPage:
//         return const ChangePasswordPage();
//
//       case serviceDetailPage:
//         return ServiceDetailPage(args: argument as ServiceDetailArgs);
//
//       case serviceDetailsPage:
//         return ServiceDetailsPage(args: argument as ServiceDetailsArgs);
//
//       case packagesPage:
//         return const PackagesPage();
//
//       case servicesPage:
//         return ServicesPage(args: argument as ServiceListArgs);
//
//       case packageDetailPage:
//         return PackageDetailPage(args: argument as PackageDetailArgs);
//     }
//
//     return const Scaffold(
//       backgroundColor: AppColors.white,
//       body: Center(
//         child: Text('Page not found'),
//       ),
//     );
//   }
// }
