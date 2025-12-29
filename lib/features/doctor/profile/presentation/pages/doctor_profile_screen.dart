import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/features/auth/data/models/doctor_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key, required this.model});

  final DoctorModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات الدكتور'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AppNavigations.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.lightColor),
        ),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: AppTextStyle.textStyle20.copyWith(
          color: AppColors.lightColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(30),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.image ?? ""),
                    radius: 60,
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "د. ${model.name} "
                          "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.textStyle18.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(5),
                        Text(
                          model.specialization ?? "",
                          style: AppTextStyle.textStyle16.copyWith(
                            color: AppColors.grayColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(model.rating.toString()),
                            Gap(5),
                            Icon(Icons.star, color: Colors.amber),
                          ],
                        ),
                        Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchUrl(
                                  Uri.parse('tel:${model.phone1 ?? ""}'),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.secondryColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text("1"), Icon(Icons.phone)],
                                ),
                              ),
                            ),
                            Gap(10),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.secondryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("2"), Icon(Icons.phone)],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              Text(
                "نبذه تعريفية",
                style: AppTextStyle.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkColor,
                ),
              ),
              Gap(5),
              Text(
                model.bio ?? "",
                style: AppTextStyle.textStyle16.copyWith(
                  color: AppColors.grayColor,
                ),
              ),
              Gap(20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.secondryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.lightColor,
                          ),
                        ),
                        Gap(10),
                        Text(
                          model.openHour.toString(),
                          style: AppTextStyle.textStyle16,
                        ),
                        Text(" : ", style: AppTextStyle.textStyle16),
                        Text(
                          model.closeHour.toString(),
                          style: AppTextStyle.textStyle16,
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.lightColor,
                          ),
                        ),
                        Gap(10),
                        Text(
                          model.address ?? "",
                          style: AppTextStyle.textStyle16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(5),
              Divider(),
              Gap(20),
              Text(
                "معلومات الأتصال",
                style: AppTextStyle.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkColor,
                ),
              ),
              Gap(10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.secondryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.email, color: AppColors.lightColor),
                        ),
                        Gap(10),
                        Text(
                          model.email ?? "",
                          style: AppTextStyle.textStyle16,
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.phone, color: AppColors.lightColor),
                        ),
                        Gap(10),
                        Text(
                          model.phone1 ?? "",
                          style: AppTextStyle.textStyle16,
                        ),
                      ],
                    ),
                    Gap(10),
                    if (model.phone2?.isEmpty == true)
                      if (model.phone2?.isEmpty != true)
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: AppColors.lightColor,
                              ),
                            ),
                            Gap(10),
                            Text(
                              model.phone2 ?? "غير متوفر",
                              style: AppTextStyle.textStyle16,
                            ),
                          ],
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          height: 55,

          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 0.0,
              textStyle: AppTextStyle.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              AppNavigations.pushTo(
                context,
                AppRoutes.bookingScreen,
                extra: model,
              );
            },
            child: Text(
              'احجز موعد الان',
              style: TextStyle(color: AppColors.lightColor),
            ),
          ),
        ),
      ),
    );
  }
}
