// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/constants/app_animation_duration.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/managers/navigation/nav_routes.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/salony_app_bar.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppThemeManager _themeManager;

  // late AuthCubit _cubit;
  bool hasNavigated = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _cubit = findDep();
    // _cubit.isAlreadyLoggedIn();
    _timer = startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // NotificationApi.checkNotificationAppLaunchDetails();
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
    return Scaffold(
      backgroundColor: _themeManager.appColors.scaffoldBgColor,
      appBar: CustomAppBar(
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
  }

  Timer startTimer() {
    var duration = const Duration(seconds: AppDuration.splashScreenDuration);
    return Timer(duration, navigate);
  }

  void navigate() {
    navigator.pushNamedAndRemoveUntil(Routes.homeScreen);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
