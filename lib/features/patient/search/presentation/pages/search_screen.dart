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

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DocCartCubit()..getdoctorsWithSearch(searchController.text),
      child: BlocBuilder<DocCartCubit, DocCartStates>(
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
                    onChanged: (_) {
                      cubit.getdoctorsWithSearch(cubit.searchController.text);
                    },
                    onFieldSubmitted: (_) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(50),
                          Text(
                            'لا يوجد دكتور بهذا الأسم',
                            style: AppTextStyle.textStyle20.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/no-search.svg',
                            width: 200,
                            height: 200,
                          ),
                        ],
                      ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: cubit.searchedDoctors.length,
                      itemBuilder: (context, index) {
                        var item = cubit.searchedDoctors[index];
                        return GestureDetector(
                          onTap: () {
                            AppNavigations.pushTo(
                              context,
                              AppRoutes.doctorProfileScreen,
                              extra: item,
                            );
                          },
                          child: Container(
                            height: 110,
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
                                    image: NetworkImage(item.image ?? ""),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Gap(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? "",
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
                                        item.specialization ?? "",
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
                                Text(item.rating.toString()),
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
      ),
    );
  }
}
