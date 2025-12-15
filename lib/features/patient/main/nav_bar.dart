import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/features/patient/appointments/presentation/pages/appointments_screen.dart';
import 'package:se7ty/features/patient/home/presentation/page/home_screen.dart';
import 'package:se7ty/features/patient/profile/presentation/pages/profile_screen.dart';
import 'package:se7ty/features/patient/search/presentation/pages/search_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: AppColors.darkColor.withValues(alpha: 0.2),
            ),
          ],
        ),
        child: GNav(
          tabBackgroundColor: AppColors.primaryColor,
          activeColor: AppColors.lightColor,
          textStyle: AppTextStyle.textStyle16.copyWith(
            color: AppColors.lightColor,
          ),
          iconSize: 24,
          selectedIndex: currentIndex,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          tabs: [
            GButton(icon: Icons.home, text: 'الرئيسية'),
            GButton(icon: Icons.search, text: 'البحث'),
            GButton(icon: Icons.calendar_month_rounded, text: 'المواعيد'),
            GButton(icon: Icons.person, text: 'الحساب'),
          ],
        ),
      ),
    );
  }
}
