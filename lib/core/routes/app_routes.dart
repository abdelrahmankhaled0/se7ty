import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ty/features/auth/data/user_type_enum.dart';
import 'package:se7ty/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ty/features/auth/presentation/pages/doctor_registration_screen.dart';
import 'package:se7ty/features/auth/presentation/pages/login_screen.dart';
import 'package:se7ty/features/auth/presentation/pages/register_screen.dart';
import 'package:se7ty/features/intro/onboarding_screen/presentation/screens/onboarding_screen.dart';
import 'package:se7ty/features/intro/splash_screen/splash_screen.dart';
import 'package:se7ty/features/intro/welcome/presentation/screens/welecome_screen.dart';
import 'package:se7ty/features/patient/home/presentation/page/home_screen.dart';
import 'package:se7ty/features/patient/main/nav_bar.dart';

class AppRoutes {
  static const String splash = "/";
  static const String onBoarding = "/onBoarding";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String doctorRegistration = "/doctorRegistration";
  static const String navBar = "/navBar";

  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelecomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(userTypeEnum: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(userTypeEnum: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: doctorRegistration,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: DoctorRegistrationScreen(),
        ),
      ),
      GoRoute(path: navBar, builder: (context, state) => NavBar()),
    ],
  );
}
