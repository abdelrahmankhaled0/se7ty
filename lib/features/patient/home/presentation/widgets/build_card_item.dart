import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/features/patient/home/data/models/card_model.dart';

class BuildCardItem extends StatelessWidget {
  const BuildCardItem({super.key, required this.model});

  final SpecializationCardModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigations.pushTo(
          context,
          AppRoutes.searchDoctorScreen,
          extra: model.specialization,
        );
      },
      child: Container(
        height: 200,
        width: 150,
        padding: EdgeInsets.only(bottom: 20),
        margin: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: model.colorPair.primary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: model.colorPair.light.withValues(alpha: 0.3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -20,
                right: -20,
                child: CircleAvatar(
                  backgroundColor: model.colorPair.light,
                  radius: 60,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset("assets/icons/doctor-card.svg", width: 140),
                  Gap(20),
                  Text(
                    textAlign: TextAlign.center,
                    model.specialization,
                    style: AppTextStyle.textStyle16.copyWith(
                      color: AppColors.lightColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
