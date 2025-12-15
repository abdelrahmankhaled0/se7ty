import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/services/local/shared_pref.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/features/intro/onboarding_screen/data/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

var pageContrller = PageController();
int currentIndex = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButton(
              onPressed: () {
                SharedPref.setOnBoardingShown();
                AppNavigations.pushReplacementTo(context, AppRoutes.welcome);
              },
              child: Text(
                'تخطي',
                style: AppTextStyle.textStyle18.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: pageContrller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: onBoardingModels.length,
            itemBuilder: (context, index) {
              final item = onBoardingModels[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      item.image,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                    ),
                    Spacer(flex: 2),
                    Text(
                      item.title,
                      style: AppTextStyle.textStyle20.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(flex: 1),
                    Text(
                      item.subTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.textStyle16.copyWith(
                        color: AppColors.darkColor.withValues(alpha: 0.7),
                      ),
                    ),

                    Spacer(flex: 4),
                    SafeArea(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SmoothPageIndicator(
                              controller: pageContrller,
                              count: onBoardingModels.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: AppColors.primaryColor,
                                dotHeight: 10,
                                dotWidth: 15,
                                expansionFactor: 2,
                              ),
                            ),
                            Spacer(),
                            if (currentIndex == onBoardingModels.length - 1)
                              SizedBox(
                                width: 90,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: AppColors.lightColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    SharedPref.setOnBoardingShown();
                                    AppNavigations.pushReplacementTo(
                                      context,
                                      AppRoutes.welcome,
                                    );
                                  },
                                  child: Text(
                                    'هيا بنا',
                                    style: AppTextStyle.textStyle16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
