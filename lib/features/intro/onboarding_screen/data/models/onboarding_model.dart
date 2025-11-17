import 'package:se7ty/core/constants/app_images.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

final List<OnboardingModel> onBoardingModels = [
  OnboardingModel(
    image: (AppImages.onBoarding1Svg),
    title: 'ابحث عن دكتور متخصص',
    subTitle:
        'اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات',
  ),
  OnboardingModel(
    image: (AppImages.onBoarding3Svg),
    title: 'سهولة الحجز',
    subTitle: 'احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان',
  ),
  OnboardingModel(
    image: (AppImages.onBoarding2Svg),
    title: 'اّمن وسري',
    subTitle: 'كُن مطمئناً لأن خصوصيتك و أمانك هما أهم أولويتنا.',
  ),
];
