import 'package:flutter/material.dart';
import 'package:se7ty/core/constants/app_images.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      AppNavigations.pushReplacementTo(context, AppRoutes.onBoarding);
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
