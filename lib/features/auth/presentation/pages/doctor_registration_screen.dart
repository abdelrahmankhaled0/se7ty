import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ty/core/constants/app_images.dart';
import 'package:se7ty/core/helpers/image_uploder.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/core/widgets/default_form_field.dart';
import 'package:se7ty/core/widgets/dialogs.dart';
import 'package:se7ty/features/auth/data/models/doctor_specializations.dart';
import 'package:se7ty/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ty/features/auth/presentation/cubit/auth_state.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  String? imagePath;
  File? file;

  Future<void> pickImage() async {
    final imagePicked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path;
        file = File(imagePicked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthSucessState) {
          AppNavigations.pop(context);
          showMyDialog(context, 'تم إضافة البياتات بنجاح', DialogType.succes);
        } else if (state is AuthErrorState) {
          AppNavigations.pop(context);
          showMyDialog(context, state.error, DialogType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'إكمال عملية التسجيل',
            style: AppTextStyle.textStyle24.copyWith(
              color: AppColors.lightColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await pickImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.lightColor,
                            backgroundImage: imagePath != null
                                ? FileImage(File(imagePath!))
                                : AssetImage(AppImages.docImage),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.lightColor,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  Text('التخصص'),
                  Gap(10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.secondryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      hint: Text('أختر التخصص'),
                      icon: Icon(Icons.expand_circle_down_outlined),
                      iconEnabledColor: AppColors.primaryColor,
                      isExpanded: true,
                      underline: SizedBox(),
                      value: cubit.specialization,
                      items: [
                        for (var specialization in specializations)
                          DropdownMenuItem(
                            value: specialization,
                            child: Text(specialization),
                          ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          cubit.specialization = newValue;
                        });
                      },
                    ),
                  ),
                  Gap(15),
                  Text('نبذة تعريفية'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.bioController,
                    text:
                        'سجل المعلومات الطبية الهامه مثل تعليمك الأكاديمي و خبراتك العملية السابقه.... ',
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "قم بكتابة المطلوب";
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  Divider(),
                  Gap(15),
                  Text('العنوان'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.adrressController,
                    text: '5_شارع مصدق_الدقي_الجيزه',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "قم بكتابة المطلوب";
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  Text('ساعات العمل :'),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(child: Text('من')),
                      Gap(15),
                      Expanded(child: Text("إلي")),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultFormField(
                          emailController: cubit.startTimeController,
                          text: '00:00',
                          onTap: () async {
                            await showStartTimePicker(context, cubit);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "قم بكتابة المطلوب";
                            }
                            return null;
                          },
                        ),
                      ),
                      Gap(15),
                      Expanded(
                        child: DefaultFormField(
                          emailController: cubit.endTimeController,
                          text: '00:00',
                          onTap: () async {
                            await showEndTimePicker(context, cubit);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "قم بكتابة المطلوب";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Gap(15),
                  Text('رقم الهاتف1 :'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.phone1Controller,
                    text: '+20xxxxxxxxxx',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "قم بكتابة المطلوب";
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  Text('رقم الهاتف2 (اختياري) :'),
                  Gap(10),
                  DefaultFormField(
                    emailController: cubit.phone2Controller,
                    text: '+20xxxxxxxxxx',
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.lightColor,
                ),
                onPressed: () async {
                  if (cubit.formKey.currentState!.validate()) {
                    if (file != null) {
                      cubit.urlImage =
                          await uploadImageToCloudinary(file!) ?? '';
                      cubit.updateDoctorData();
                    } else {
                      showMyDialog(
                        context,
                        'قم بإختيار صورة الصفحه الشخصيه',
                        DialogType.error,
                      );
                    }
                  }
                },
                child: Text(
                  'التسجيل',
                  style: AppTextStyle.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showStartTimePicker(BuildContext context, AuthCubit cubit) async {
  final startTimePicked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (startTimePicked != null) {
    cubit.startTimeController.text = startTimePicked.format(context).toString();
  }
}

Future<void> showEndTimePicker(BuildContext context, AuthCubit cubit) async {
  final endTimePicked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(
      DateTime.now().add(Duration(minutes: 30)),
    ),
  );
  if (endTimePicked != null) {
    cubit.endTimeController.text = endTimePicked.format(context).toString();
  }
}
