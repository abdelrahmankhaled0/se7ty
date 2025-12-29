import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/core/widgets/default_form_field.dart';
import 'package:se7ty/features/patient/home/data/models/card_model.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_cubit.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_states.dart';
import 'package:se7ty/features/patient/home/presentation/widgets/build_card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.model});

  final SpecializationCardModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocCartCubit()..getDocData(),
      child: BlocConsumer<DocCartCubit, DocCartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DocCartCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'صحَتي',
                style: AppTextStyle.textStyle24.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'مرحبًا، ',
                            style: AppTextStyle.textStyle16.copyWith(
                              color: AppColors.darkColor,
                            ),
                          ),
                          TextSpan(
                            text:
                                FirebaseAuth.instance.currentUser?.displayName,
                            style: AppTextStyle.textStyle18.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.waving_hand,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Text(
                      'احجز الأن و كن جزءًا من رحلتك الصحية.',
                      style: AppTextStyle.textStyle26.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(20),
                    DefaultFormField(
                      emailController: cubit.searchController,
                      text: 'ابحث عن دكتور',
                      textInputAction: TextInputAction.search,
                      suffixIcon: Icons.search,
                      onSuffixPressed: () {
                        AppNavigations.pushTo(
                          context,
                          AppRoutes.homeSearchScreen,
                          extra: cubit.searchController.text,
                        );
                      },
                      onFieldSubmitted: (value) {
                        AppNavigations.pushTo(
                          context,
                          AppRoutes.homeSearchScreen,
                          extra: cubit.searchController.text,
                        );
                      },
                    ),
                    Gap(20),
                    Text(
                      'التخصصات',
                      style: AppTextStyle.textStyle16.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(10),
                    SizedBox(
                      width: double.infinity,
                      height: 230,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: specializationList.length,
                        itemBuilder: (context, index) {
                          var model = specializationList[index];
                          return BuildCardItem(model: model);
                        },
                      ),
                    ),
                    Gap(20),
                    Text(
                      'الأعلى تقيمًا',
                      style: AppTextStyle.textStyle16.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(15),
                    if (state is DocCartLoadingState)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),

                    if (state is DocCartErrorState) Text('error'),

                    if (state is DocCartSuccessState)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = cubit.doctors[index];
                          return GestureDetector(
                            onTap: () {
                              AppNavigations.pushTo(
                                context,
                                AppRoutes.doctorProfileScreen,
                                extra: doctor,
                              );
                            },
                            child: Container(
                              height: 120,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.secondryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(13),
                                    ),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColors.lightColor,
                                      ),
                                      child: Image.network(
                                        doctor.image ?? '',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          doctor.name ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle.textStyle18
                                              .copyWith(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Gap(5),
                                        Text(
                                          doctor.specialization ?? "",
                                          style: AppTextStyle.textStyle16
                                              .copyWith(
                                                color: AppColors.grayColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(doctor.rating.toString()),
                                  Gap(5),
                                  Icon(Icons.star, color: Colors.amber),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
