import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_cubit.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_states.dart';

class SpecializationSearchDoctorScreen extends StatelessWidget {
  const SpecializationSearchDoctorScreen({
    super.key,
    required this.specialization,
  });

  final String specialization;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocCartCubit, DocCartStates>(
      builder: (context, state) {
        var cubit = DocCartCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('ابحث عن دكتور'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
            titleTextStyle: AppTextStyle.textStyle20.copyWith(
              color: AppColors.lightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is DocCartLoadingState)
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                if (state is DocCartErrorState) Text('حدث خطاءًا ما'),
                if (state is DocCartSuccessState)
                  if (cubit.specializedDoctors.isEmpty)
                    Column(
                      children: [
                        Gap(100),
                        Text(
                          'لا يوجد دكاترة',
                          style: AppTextStyle.textStyle20.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Center(
                          child: SvgPicture.asset(
                            'assets/icons/no-search.svg',
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ],
                    ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.specializedDoctors.length,
                    itemBuilder: (context, index) {
                      var model = cubit.specializedDoctors[index];
                      return GestureDetector(
                        onTap: () {
                          AppNavigations.pushTo(
                            context,
                            AppRoutes.doctorProfileScreen,
                            extra: model,
                          );
                        },
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.secondryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  image: NetworkImage(model.image ?? ''),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Gap(15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      model.name ?? "",
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
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(model.rating.toString()),
                              Gap(5),
                              Icon(Icons.star, color: Colors.amber),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
