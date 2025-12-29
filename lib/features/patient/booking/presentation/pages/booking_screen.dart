import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/core/widgets/default_form_field.dart';
import 'package:se7ty/features/auth/data/models/doctor_model.dart';
import 'package:se7ty/features/patient/booking/presentation/cubit/booking_cubit.dart';
import 'package:se7ty/features/patient/home/presentation/widgets/doctor_cart.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.model});

  final DoctorModel model;

  @override
  Widget build(BuildContext context) {
    final cubit = BookingCubit.get(context);
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
        child: Column(
          children: [
            doctorCard(model),
            Gap(10),
            Text(
              '--ادخل بيانات الحجز--',
              style: AppTextStyle.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            Gap(20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('اسم المريض'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.patientNameControler,
                    text: 'الأسم',
                  ),
                  Gap(20),
                  Text('رقم الهاتف'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.phoneControler,
                    text: '+20**********',
                  ),
                  Gap(20),
                  Text('وصف الحالة'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.descreptionControler,
                    text: 'الوصف',
                    maxLines: 4,
                  ),
                  Gap(20),
                  Text('تاريخ الحجز'),
                  Gap(10),
                  DefaultFormField(
                    textInputAction: TextInputAction.done,
                    emailController: cubit.dateControler,
                    text: '',
                    suffixIcon: Icons.date_range_outlined,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30)),
                      );
                      if (selectedDate != null) {
                        cubit.dateControler.text =
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
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
            onPressed: () {},
            child: Text(
              'تأكيد الحجز',
              style: TextStyle(color: AppColors.lightColor),
            ),
          ),
        ),
      ),
    );
  }
}
