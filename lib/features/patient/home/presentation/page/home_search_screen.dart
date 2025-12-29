import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/core/widgets/default_form_field.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_cubit.dart';
import 'package:se7ty/features/patient/home/presentation/cubit/doctor_cart_cubit/doctor_cart_states.dart';
import 'package:se7ty/features/patient/home/presentation/widgets/doctor_cart.dart';

class HomeSearchScreen extends StatelessWidget {
  const HomeSearchScreen({super.key, required this.searchKey});

  final String searchKey;

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
                DefaultFormField(
                  emailController: cubit.searchController,
                  text: 'البحث',
                  suffixIcon: Icons.search,
                  onSuffixPressed: () {
                    cubit.getdoctorsWithSearch(cubit.searchController.text);
                  },
                  onChanged: (value) {
                    cubit.getdoctorsWithSearch(cubit.searchController.text);
                  },
                  onFieldSubmitted: (value) {
                    cubit.getdoctorsWithSearch(cubit.searchController.text);
                  },
                ),
                Gap(15),
                if (state is DocCartLoadingState)
                  CircularProgressIndicator(color: AppColors.primaryColor),
                if (state is DocCartErrorState) Text('حدث خكاءًل ما'),
                if (state is DocCartSuccessState)
                  if (cubit.searchedDoctors.isEmpty)
                    Column(
                      children: [
                        Gap(100),
                        Text(
                          'لا يوجد دكتور بهذا الأسم',
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
                    itemCount: cubit.searchedDoctors.length,
                    itemBuilder: (context, index) {
                      var doctor = cubit.searchedDoctors[index];
                      return GestureDetector(
                        onTap: () {
                          AppNavigations.pushTo(
                            context,
                            AppRoutes.doctorProfileScreen,
                            extra: doctor,
                          );
                        },
                        child: doctorCard(doctor),
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
