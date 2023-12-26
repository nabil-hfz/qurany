// Flutter imports:
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:salon_app/core/managers/managers.dart';
import 'package:salon_app/core/utils/utl_device.dart';
import 'package:salon_app/core/widgets/image/images_gallery_view_widget.dart';
import 'package:salon_app/main_prod.dart';
import 'package:salon_app/modules/application/ui/pages/feedback_page.dart';
import 'package:salon_app/modules/auth/ui/args/edit_profile_args.dart';
import 'package:salon_app/modules/auth/ui/args/login_args.dart';
import 'package:salon_app/modules/auth/ui/args/login_social_args.dart';
import 'package:salon_app/modules/auth/ui/args/reset_password_args.dart';
import 'package:salon_app/modules/auth/ui/args/verify_args.dart';
import 'package:salon_app/modules/auth/ui/pages/change_email_page.dart';
import 'package:salon_app/modules/auth/ui/pages/change_password_page.dart';
import 'package:salon_app/modules/auth/ui/pages/confirm_auth_info_page.dart';
import 'package:salon_app/modules/auth/ui/pages/edit_profile_page.dart';
import 'package:salon_app/modules/auth/ui/pages/forget_password_page.dart';
import 'package:salon_app/modules/auth/ui/pages/log_in_page.dart';
import 'package:salon_app/modules/auth/ui/pages/register_page.dart';
import 'package:salon_app/modules/auth/ui/pages/reset_password_page.dart';
import 'package:salon_app/modules/bookings/ui/args/booking_add_args.dart';
import 'package:salon_app/modules/bookings/ui/args/booking_details_args.dart';
import 'package:salon_app/modules/bookings/ui/args/booking_successful_args.dart';
import 'package:salon_app/modules/bookings/ui/pages/add_booking_page.dart';
import 'package:salon_app/modules/bookings/ui/pages/booking_details.dart';
import 'package:salon_app/modules/bookings/ui/pages/booking_successful_page.dart';
import 'package:salon_app/modules/bookings/ui/pages/bookings_list_page.dart';
import 'package:salon_app/modules/bookings/ui/pages/check_out_page.dart';
import 'package:salon_app/modules/cart/ui/pages/carts_list_page.dart';
import 'package:salon_app/modules/catalogue/ui/pages/catalog_page.dart';
import 'package:salon_app/modules/gallery/ui/args/gallery_folder_images_args.dart';
import 'package:salon_app/modules/gallery/ui/pages/gallery_folder_images_list_page.dart';
import 'package:salon_app/modules/home/ui/pages/home_page.dart';
import 'package:salon_app/modules/introduction/pages/introducation_page.dart';
import 'package:salon_app/modules/main_root/ui/pages/main_root_page.dart';
import 'package:salon_app/modules/main_root/ui/pages/not_found_page.dart';
import 'package:salon_app/modules/more/ui/pages/contact_us_page.dart';
import 'package:salon_app/modules/more/ui/pages/delete_account_page.dart';
import 'package:salon_app/modules/more/ui/pages/more_page.dart';
import 'package:salon_app/modules/more/ui/pages/my_favorite_page.dart';
import 'package:salon_app/modules/more/ui/pages/notification_settings_page.dart';
import 'package:salon_app/modules/more/ui/pages/notifications_page.dart';
import 'package:salon_app/modules/more/ui/pages/privacy_policy_page.dart';
import 'package:salon_app/modules/more/ui/pages/settings_page.dart';
import 'package:salon_app/modules/more/ui/pages/ssettings_account_page.dart';
import 'package:salon_app/modules/more/ui/pages/terms_of_use_page.dart';
import 'package:salon_app/modules/more/ui/pages/user_data_deletion_page.dart';
import 'package:salon_app/modules/packages/ui/args/package_args.dart';
import 'package:salon_app/modules/packages/ui/args/packages_list_args.dart';
import 'package:salon_app/modules/packages/ui/pages/package_details.dart';
import 'package:salon_app/modules/packages/ui/pages/packages_list_page.dart';
import 'package:salon_app/modules/salons/ui/args/salon_args.dart';
import 'package:salon_app/modules/salons/ui/pages/salon_details_page.dart';
import 'package:salon_app/modules/search/ui/args/filter_args.dart';
import 'package:salon_app/modules/search/ui/args/search_args.dart';
import 'package:salon_app/modules/search/ui/pages/filter_page.dart';
import 'package:salon_app/modules/search/ui/pages/search_page.dart';
import 'package:salon_app/modules/services/ui/args/service_details_args.dart';
import 'package:salon_app/modules/services/ui/args/services_list_args.dart';
import 'package:salon_app/modules/services/ui/pages/service_details_page.dart';
import 'package:salon_app/modules/services/ui/pages/services_page.dart';
import 'package:salon_app/modules/spalsh/ui/pages/splash_page.dart';
import 'package:salon_app/modules/tag/ui/args/add_tag_args.dart';
import 'package:salon_app/modules/tag/ui/pages/tag_detail_page.dart';

@Singleton()
class AppNavigator {
  AppNavigator();

  GlobalKey<NavigatorState> get navigatorKey => AppRouter._navigatorKey;

  GoRouter get router => AppRouter._router;

  Future<Object?> pushNamed(
    String routeName, {
    dynamic arguments,
  }) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    return router.pushNamed(routeName, extra: arguments);
    // _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  void go<T>(String routeName, {dynamic arguments}) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    router.go(routeName, extra: arguments);
    // _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  void goNamed<T>(
    String routeName, {
    dynamic arguments,
    required Map<String, String> pathParameters,
  }) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    router.goNamed(
      routeName,
      extra: arguments,
      pathParameters: pathParameters,
    );
    // _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  void pushReplacementNamed<T>(String routeName, {dynamic arguments}) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    router.pushReplacementNamed(routeName, extra: arguments);

    // _navigatorKey.currentState!
    //     .pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil<T>(String routeName, {Object? arguments}) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    while (router.canPop()) {
      router.pop();
    }
    router.pushReplacementNamed(routeName, extra: arguments);

    // _navigatorKey.currentState!.pushNamedAndRemoveUntil(
    //   routeName,
    //   (Route<dynamic> route) => false,
    //   arguments: arguments,
    // );
  }

  void pop<T>([T? result]) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    if (canPop()) router.pop(result);
    // return _navigatorKey.currentState!.pop(result);
  }

  bool canPop() {
    return router.canPop();
    // return _navigatorKey.currentState!.canPop();
  }

// offAll<T>(String routeName, {dynamic arguments, T? result}) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   _navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
//     routeName,
//     (route) => false,
//   );
// }

// void pushNamedIfNotCurrent(
//   String routeName, {
//   Object? arguments,
// }) {
//   if (!isCurrent(routeName)) {
//     pushNamed(routeName, arguments: arguments);
//   }
// }

// void pushReplacementNamedIfNotCurrent(
//   String routeName, {
//   Object? arguments,
// }) {
//   if (!isCurrent(routeName)) {
//     pushReplacementNamed(
//       routeName,
//       arguments: arguments,
//     );
//   }
// }

// bool isCurrent(String routeName) {
//   bool isCurrent = false;
//   _navigatorKey.currentState!.popUntil((route) {
//     if (route.settings.name == routeName) {
//       isCurrent = true;
//     }
//     return true;
//   });
//   return isCurrent;
// }
}

abstract class AppRouter {
  static const ValueKey<String> _scaffoldKey = ValueKey<String>('App scaffold');

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        name: Routes.root,
        path: Routes.root,
        redirect: (context, state) => Routes.splash,
      ),
      GoRoute(
        name: Routes.mainRootPage,
        path: Routes.mainRootPage,
        redirect: (context, state) => Routes.homePage,
      ),
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = SplashPage();
          return pageBuilder(context, state, child);
        },
      ),

      /// User management.
      GoRoute(
        name: Routes.changePasswordPage,
        path: Routes.changePasswordPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = ChangePasswordPage();
          return pageBuilder(context, state, child);
        },
      ),

      /// Main management.
      GoRoute(
        name: Routes.homePage,
        path: Routes.homePage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = MainRootPage(
            currentTab: CurrentTab.home,
            child: HomePage(),
          );
          return pageBuilder(context, state, child, key: _scaffoldKey);
        },
      ),
      GoRoute(
        name: Routes.cataloguePage,
        path: Routes.cataloguePage,
        redirect: (_, __) => Routes.catalogueServicesPage,
      ),
      GoRoute(
        name: Routes.catalogueKindPage,
        path: Routes.catalogueKindPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var kind = state.pathParameters['kind']!;
          final child = MainRootPage(
            currentTab: CurrentTab.catalog,
            child: CataloguePage(kind),
          );
          return pageBuilder(context, state, child, key: _scaffoldKey);
        },
        routes: <GoRoute>[
          GoRoute(
            path: ':packageId',
            builder: (BuildContext context, GoRouterState state) {
              var navArgs = state.extra as BaseNavigationArg;
              var args = navArgs.data as PackageDetailsArgs;

              return PackageDetails(args: args);
            },
          ),
        ],
      ),
      // GoRoute(
      //   name: Routes.clientsPage,
      //   path: Routes.clientsPage,
      //   pageBuilder: (BuildContext context, GoRouterState state) {
      //     final child = MainRootPage(
      //       currentTab: CurrentTab.booking,
      //       child: Text(Translations.of(context).clients),
      //     );
      //     return pageBuilder(context, state, child, _scaffoldKey);
      //   },
      // ),
      GoRoute(
        name: Routes.bookingsListPage,
        path: Routes.bookingsListPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = BookingsListPage();
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.bookingDetailsPage,
        path: Routes.bookingDetailsPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as BookingDetailsArgs;

          final child = BookingDetails(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.addBookingPage,
        path: Routes.addBookingPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as AddBookingArgs;

          final child = AddBookingPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.bookingCheckOutPage,
        path: Routes.bookingCheckOutPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          // var navArgs = state.extra as BaseNavigationArg;
          const child = CheckOutPage();
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.bookingSuccessfulPage,
        path: Routes.bookingSuccessfulPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = (navArgs.data as BookingSuccessfulArgs);
          final child = BookingSuccessfulPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.cartsPage,
        path: Routes.cartsPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = MainRootPage(
            currentTab: CurrentTab.cart,
            child: CartsPage(),
          );
          return pageBuilder(context, state, child, key: _scaffoldKey);
        },
      ),
      // GoRoute(
      //   name: Routes.offersPage,
      //   path: Routes.offersPage,
      //   pageBuilder: (BuildContext context, GoRouterState state) {
      //     final child = MainRootPage(
      //       currentTab: CurrentTab.offers,
      //       child: Text(Translations.of(context).offers),
      //     );
      //     return pageBuilder(context, state, child, _scaffoldKey);
      //   },
      // ),

      GoRoute(
        name: Routes.morePage,
        path: Routes.morePage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = MainRootPage(
            currentTab: CurrentTab.more,
            child: MorePage(),
          );
          return pageBuilder(context, state, child, key: _scaffoldKey);
        },
      ),
      GoRoute(
        name: Routes.myFavoritesPage,
        path: Routes.myFavoritesPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          // var navArgs = state.extra as BaseNavigationArg?;
          // var args = navArgs?.data as EditProfileArgs?;

          const child = MyFavoritePage();

          return pageBuilder(context, state, child);
        },
      ),
      // GoRoute(
      //   name: Routes.staffListPage,
      //   path: Routes.staffListPage,
      //   pageBuilder: (BuildContext context, GoRouterState state) {
      //     const child = StaffsListPage();
      //     return pageBuilder(context, state, child);
      //   },
      // ),

      GoRoute(
        name: Routes.notificationsPage,
        path: Routes.notificationsPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = NotificationsPage();
          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.notificationsSettingsPage,
        path: Routes.notificationsSettingsPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = NotificationsSettingsPage();

          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.feedbackPage,
        path: Routes.feedbackPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = FeedbackPage();

          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.changeEmailPage,
        path: Routes.changeEmailPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = ChangeEmailPage();
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.settingsPage,
        path: Routes.settingsPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = SettingsPage();

          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.contactUsPage,
        path: Routes.contactUsPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = ContactUsPage();

          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.settingsAccountPage,
        path: Routes.settingsAccountPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = SettingsAccountPage();

          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.deleteAccountPage,
        path: Routes.deleteAccountPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = DeleteAccountPage();

          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.privacyPolicyPage,
        path: Routes.privacyPolicyPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          const child = PrivacyPolicyPage();

          return pageBuilder(context, state, child, navArgs: navArgs);
        },
      ),
      GoRoute(
        name: Routes.termsOfUsePage,
        path: Routes.termsOfUsePage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          const child = TermsOfUsePage();

          return pageBuilder(context, state, child, navArgs: navArgs);
        },
      ),
      GoRoute(
        name: Routes.userDataDeletionPage,
        path: Routes.userDataDeletionPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          const child = UserDataDeletionPage();

          return pageBuilder(context, state, child, navArgs: navArgs);
        },
      ),

      GoRoute(
        name: Routes.serviceDetailPage,
        path: Routes.serviceDetailPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as ServiceDetailsArgs;

          final child = ServiceDetailsPage(args: args);

          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.packageDetails,
        path: Routes.packageDetails,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as PackageDetailsArgs;

          final child = PackageDetails(args: args);

          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.servicesPage,
        path: Routes.servicesPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as ServiceListArgs;

          final child = ServicesPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.packagesPage,
        path: Routes.packagesPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as PackageListArgs;

          final child = PackagesPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.galleryFolderImagesListPage,
        path: Routes.galleryFolderImagesListPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as GalleryImagesArgs;

          final child = GalleryFolderImagesListPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.galleryFullViewWidget,
        path: Routes.galleryFullViewWidget,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as GalleryImagesArgs;

          final child = GalleryFullViewWidget(args: args);
          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.addTagPage,
        path: Routes.addTagPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as AddTagArgs;

          final child = AddTagPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.searchPage,
        path: Routes.searchPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as SearchArgs;

          final child = SearchPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.filterPage,
        path: Routes.filterPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as FilterArgs;

          final child = FilterPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      // GoRoute(
      //   path: '/api/app/client-salon/details/:id',
      //   builder: (_, gpath) => Scaffold(
      //     appBar: AppBar(
      //         title: Text(
      //             'Details Screen ${gpath.pathParameters['id'] ?? 'Null'}')),
      //   ),
      // ),
      GoRoute(
        // adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://api.smartbookli.com/api/app/client-salon/3a0e8dba-c9d3-a686-7272-455b5a03b985"' com.tiin.client
        name: Routes.salonDetails,
        path: Routes.salonDetails,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          var args = navArgs?.data as SalonDetailsArgs?;

          final child = SalonDetailsPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),

      /// User management.
      GoRoute(
        name: Routes.signUpPage,
        path: Routes.signUpPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          var args = navArgs?.data as LoginSocialArgs?;

          final child = RegisterPage(args: args);

          //LoginSocialArgs
          return pageBuilder(context, state, child);
        },
      ),

      /// User management.
      GoRoute(
        name: Routes.editProfilePage,
        path: Routes.editProfilePage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          var args = navArgs?.data as EditProfileArgs?;

          final child = EditProfilePage(args: args);

          //LoginSocialArgs
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.logInPage,
        path: Routes.logInPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg?;
          var args = navArgs?.data as LoginArgs?;
          Widget child = LoginPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.confirmAuthInfoPage,
        path: Routes.confirmAuthInfoPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as VerifyArgs;
          final child = ConfirmAuthInfoPage(
            args: args,
          );
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.forgetPasswordPage,
        path: Routes.forgetPasswordPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = ForgetPasswordPage();
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.resetPasswordPage,
        path: Routes.resetPasswordPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as ResetPasswordArgs;
          final child = ResetPasswordPage(
            args: args,
          );
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.introductionPage,
        path: Routes.introductionPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          const child = IntroductionPage();

          return pageBuilder(context, state, child);
        },
      ),
    ],

    // redirect: _guard,
    // refreshListenable: _auth,
    debugLogDiagnostics: !isProduction,
    // debugLogDiagnostics: true,
    // debugLogDiagnostics: true,
  );

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundPage();

  // static String? _guard(BuildContext context, GoRouterState state) {
  //   final bool signedIn = false; //_auth.signedIn;
  //   final bool signingIn = state.matchedLocation == '/signin';
  //
  //   // Go to /signin if the user is not signed in
  //   if (!signedIn && !signingIn) {
  //     return '/signin';
  //   }
  //   // Go to /books if the user is signed in and tries to go to /signin.
  //   else if (signedIn && signingIn) {
  //     return '/books';
  //   }
  //
  //   // no redirect
  //   return null;
  // }

  static Page pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget child, {
    LocalKey? key,
    BaseNavigationArg? navArgs,
  }) {
    if (navArgs != null) {
      if (navArgs.navigationType == NavigationType.slideVertical) {
        return VerticalSlideTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.slideHorizontalLeft) {
        return HorizontalSlideLeftTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.slideHorizontalRight) {
        return HorizontalSlideRightTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.fadeScale) {
        return FadeScaleTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.fadeThrough) {
        return FadeThroughTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.sharedAxisTransition) {
        return SharedAxisTransitionPage(
          child: child,
          key: key ?? state.pageKey,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      }
    }

    return FadeTransitionPage(
      key: key ?? state.pageKey,
      child: child,
    );
  }
//
// // all the route paths. So that we can access them easily  across the app
//   static const root = '/';
// // static const singleArticle = '/article';
//
//   static mainPage([CurrentTab? type]) => '/${type?.name ?? ':type'}';
// // static const singleArticleWithParams = '/article/:id';
//   /// get route name with parameters, here [id] is optional because we need [:id] to define path on [_singleArticleWithParams]
//   static singleArticleWithParams([String? id]) => '/article/${id ?? ':id'}';
//
//   /// private static methods that are accessible only in this class and not from outside
//   static Widget _mainPageRouteBuilder(
//           BuildContext context, GoRouterState state) =>
//       MainRootPage(
//           currentTab: state.params['type']! == CurrentTab.blogs.name
//               ? CurrentTab.blogs
//               : CurrentTab.favorite);
//
//   static Widget _singleBlog(BuildContext context, GoRouterState state) =>
//       SingleArticle(blog: state.extra as Blog);
//   static Widget _singleArticleWithParams(
//           BuildContext context, GoRouterState state) =>
//       SingleArticleWithParams(id: state.params["id"]!);
//
//   static Widget errorWidget(BuildContext context, GoRouterState state) =>
//       const NotFoundPage();
//
//   /// use this in [MaterialApp.router]
//   static final GoRouter _router = GoRouter(
//     routes: <GoRoute>[
//       GoRoute(
//           path: root,
//           redirect: (context, state) => mainPage(CurrentTab.calendar)),
//       GoRoute(path: mainPage(), builder: _mainPageRouteBuilder),
//       // GoRoute(path: singleArticle, builder: _singleBlog),
//       GoRoute(
//           path: singleArticleWithParams(), builder: _singleArticleWithParams)
//     ],
//     errorBuilder: errorWidget,
//   );
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

class VerticalSlideTransitionPage extends CustomTransitionPage<void> {
  VerticalSlideTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: _offsetTween.chain(_curveTween).animate(animation),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
  static final Tween<Offset> _offsetTween = Tween(
    begin: const Offset(0, 1),
    end: const Offset(0, 0),
  );
}

class HorizontalSlideLeftTransitionPage extends CustomTransitionPage<void> {
  HorizontalSlideLeftTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: _leftOffsetTween.chain(_curveTween).animate(animation),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
  static final Tween<Offset> _leftOffsetTween = Tween(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  );
}

class HorizontalSlideRightTransitionPage extends CustomTransitionPage<void> {
  HorizontalSlideRightTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: _rightOffsetTween.chain(_curveTween).animate(animation),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
  static final Tween<Offset> _rightOffsetTween = Tween(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  );
}

class FadeScaleTransitionPage extends CustomTransitionPage<void> {
  FadeScaleTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeScaleTransition(
              animation: animation,
              child: child,
              // secondaryAnimation: secondaryAnimation,
            );
          },
        );
}

class FadeThroughTransitionPage extends CustomTransitionPage<void> {
  FadeThroughTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        );
}

class SharedAxisTransitionPage extends CustomTransitionPage<void> {
  final SharedAxisTransitionType transitionType;

  SharedAxisTransitionPage({
    required LocalKey key,
    required Widget child,
    required this.transitionType,
  }) : super(
          key: key,
          child: child,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType,
              child: child,
            );
          },
        );
}
