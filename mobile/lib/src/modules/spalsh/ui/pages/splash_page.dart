// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salon_app/core/bloc/base/states/base_success_state.dart';
import 'package:salon_app/core/constants/app_animation_duration.dart';
import 'package:salon_app/core/di/di.dart';
import 'package:salon_app/core/generated_files/assets/assets.gen.dart';
import 'package:salon_app/core/managers/managers.dart';
import 'package:salon_app/core/managers/notification/notification_api.dart';
import 'package:salon_app/core/utils/utils.dart';
import 'package:salon_app/core/widgets/common/salony_app_bar.dart';
import 'package:salon_app/core/widgets/image/app_image_widget.dart';
import 'package:salon_app/modules/auth/domain/blocs/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppThemeManager _themeManager;
  late AuthCubit _cubit;
  bool hasNavigated = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _cubit = findDep();
    _cubit.isAlreadyLoggedIn();
    _timer = startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NotificationApi.checkNotificationAppLaunchDetails();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeManager = context.read<AppThemeManager>();
  }

  @override
  Widget build(BuildContext context) {
    double width = DeviceUtils.getScaledWidth(context, 1);
    double height = DeviceUtils.getScaledHeight(context, 1);
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.isLoggedIn is AppFirstLoadSuccess) {
          navigator.pushNamedAndRemoveUntil(Routes.introductionPage);
          return;
        }
        if (state.isLoggedIn is LoggedInAlreadySuccess) {
          if (mounted) {
            setState(() {
              hasNavigated = true;
            });
          }
          // final profile = (state.isLoggedIn as LoggedInAlreadySuccess).profile;
          // appPrint('1 profile is ${state.isLoggedIn} ------ $profile');
          navigator.pushNamedAndRemoveUntil(Routes.mainRootPage);
        } else if (state.isLoggedIn is BaseSuccessState) {
          if (mounted) {
            setState(() {
              hasNavigated = true;
            });
          }
          navigator.pushNamedAndRemoveUntil(Routes.logInPage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _themeManager.appColors.scaffoldBgColor,
          appBar: SalonyAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: _themeManager.appColors.splashAppBarColor,
          ),
          body: SafeArea(
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: AppImageWidget(
                  path: Assets.images.appLauncher.path,
                  width: 160,
                  height: 160,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Timer startTimer() {
    var duration = const Duration(seconds: AppDuration.splashScreenDuration);
    return Timer(duration, navigate);
  }

  void navigate() async {
    if (!hasNavigated) {
      navigator.pushNamedAndRemoveUntil(Routes.logInPage);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
