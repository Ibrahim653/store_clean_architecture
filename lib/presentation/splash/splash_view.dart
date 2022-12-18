import 'dart:async';

import 'package:advanced_app/presentation/resourses/assets_manager.dart';
import 'package:advanced_app/presentation/resourses/color_manager.dart';
import 'package:advanced_app/presentation/resourses/constants_manager.dart';
import 'package:advanced_app/presentation/resourses/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreference _appPreference = instance<AppPreference>();

  _startDelay() {
    Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreference.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {Navigator.of(context).pushReplacementNamed(Routes.mainRoute)}
          else
            {
              _appPreference
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset(ImageAssets.splashLogo)),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
