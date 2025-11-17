import 'package:go_router/go_router.dart';
import 'package:se7ty/features/auth/presentation/pages/login_screen.dart';
import 'package:se7ty/features/intro/onboarding_screen/presentation/screens/onboarding_screen.dart';
import 'package:se7ty/features/intro/splash_screen/splash_screen.dart';
import 'package:se7ty/features/intro/welcome/presentation/screens/welecome_screen.dart';

class AppRoutes {
  static const String splash = "/";
  static const String onBoarding = "/onBoarding";
  static const String welcome = "/welcome";
  static const String login = "/login";

  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelecomeScreen()),
      GoRoute(path: login, builder: (context, state) => LoginScreen()),
    ],
  );
}
