import 'package:flutter/material.dart';
import 'package:se7ty/core/constants/app_images.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/services/local/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isOnBoardingShown = SharedPref.getOnBoardingShown();
    Future.delayed(Duration(seconds: 3), () {
      if (isOnBoardingShown) {
        AppNavigations.pushReplacementTo(context, AppRoutes.welcome);
      } else {
        AppNavigations.pushReplacementTo(context, AppRoutes.onBoarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppImages.logoImage, width: 250)),
    );
  }
}
