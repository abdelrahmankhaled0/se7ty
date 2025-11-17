import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/constants/app_images.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';

class WelecomeScreen extends StatelessWidget {
  const WelecomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.welcomeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 1),
                Text(
                  'اهلاً بك ',
                  style: AppTextStyle.textStyle38.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(5),
                Text(
                  'سجل واحجز عند دكتورك وانت فالبيت',
                  style: AppTextStyle.textStyle18.copyWith(
                    color: AppColors.darkColor.withValues(alpha: 0.7),
                  ),
                ),
                Spacer(flex: 4),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Spacer(flex: 1),
                      Text(
                        'سجل دلوقتي كـ',
                        style: AppTextStyle.textStyle20.copyWith(
                          color: AppColors.lightColor,
                        ),
                      ),
                      Spacer(flex: 2),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.darkColor,
                            textStyle: AppTextStyle.textStyle20,
                            backgroundColor: AppColors.lightColor.withValues(
                              alpha: 0.7,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'دكتور',
                            style: AppTextStyle.textStyle20.copyWith(
                              color: AppColors.darkColor.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.darkColor,
                            textStyle: AppTextStyle.textStyle20,
                            backgroundColor: AppColors.lightColor.withValues(
                              alpha: 0.7,
                            ),
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            AppNavigations.pushTo(context, AppRoutes.login);
                          },
                          child: Text(
                            'مريض',
                            style: AppTextStyle.textStyle20.copyWith(
                              color: AppColors.darkColor.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
