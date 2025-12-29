import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/features/auth/data/models/doctor_model.dart';

Container doctorCard(DoctorModel doctor) {
  return Container(
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
            image: NetworkImage(doctor.image ?? ""),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        Gap(10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.textStyle18.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5),
              Text(
                doctor.specialization ?? "",
                style: AppTextStyle.textStyle16.copyWith(
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
  );
}
