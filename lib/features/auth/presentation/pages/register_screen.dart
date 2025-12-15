import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/constants/app_images.dart';
import 'package:se7ty/core/routes/app_navigations.dart';
import 'package:se7ty/core/routes/app_routes.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/core/widgets/default_button.dart';
import 'package:se7ty/core/widgets/default_form_field.dart';
import 'package:se7ty/core/widgets/dialogs.dart';
import 'package:se7ty/features/auth/data/user_type_enum.dart';
import 'package:se7ty/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ty/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7ty/features/auth/presentation/widgets/default_row_for_togle_between_login_and_register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.userTypeEnum});

  final UserTypeEnum userTypeEnum;

  String userType() {
    return userTypeEnum == UserTypeEnum.doctor ? 'دكتور' : 'مريض';
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
          showMyDialog(context, 'تم تسجيل حاسب جديد بنجاح', DialogType.succes);
          if (userTypeEnum == UserTypeEnum.doctor) {
            AppNavigations.pushReplacementTo(
              context,
              AppRoutes.doctorRegistration,
            );
          } else {
            AppNavigations.pushReplacementTo(context, AppRoutes.navBar);
          }
        } else if (state is AuthErrorState) {
          AppNavigations.pop(context);
          showMyDialog(context, state.error, DialogType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Image(
                    image: AssetImage(AppImages.logoImage),
                    width: MediaQuery.sizeOf(context).width * 0.5,
                  ),
                  Text(
                    'سجل حساب جديد كـ "${userType()}"',
                    style: AppTextStyle.textStyle20.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(40),
                  DefaultFormField(
                    emailController: cubit.usernameController,
                    text: "الأسم",
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل اسم المستخدم";
                      }
                      // if (!AppRegex.isEmailValid(value)) {
                      //   return "يجب أن يبدأ اسم المستخدم بحرف\nاسم المستخدم يجب أن يتكون من 3 إلى 18 حرف\nيسمح فقط بالحروف والأرقام وعلامة _";
                      // }
                      return null;
                    },
                  ),
                  Gap(20),
                  DefaultFormField(
                    emailController: cubit.emailController,
                    text: 'abdelrahman@example.com',
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل البريد الإلكتروني";
                      }
                      // if (!AppRegex.isEmailValid(value)) {
                      //   return "صيغة البريد الإلكتروني غير صحيحة";
                      // }
                      return null;
                    },
                  ),
                  Gap(20),
                  DefaultFormField(
                    emailController: cubit.passwordController,
                    text: '*************',
                    prefixIcon: Icons.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل كلمة المرور";
                      }
                      // if (!AppRegex.isPasswordValid(value)) {
                      //   return "كلمة المرور يجب ألا تقل عن 8 أحرف\nيجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل\nيجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل\nيجب أن تحتوي كلمة المرور على رقم واحد على الأقل\nيجب أن تحتوي كلمة المرور على رمز (مثل ! @ # \$ % &)";
                      // }
                      return null;
                    },
                  ),
                  Gap(20),
                  DefaultButton(
                    text: "تسجيل حساب جديد",
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.register(userTypeEnum: userTypeEnum);
                      }
                    },
                  ),
                  Gap(20),
                  DefaultRowForTogleBetweenLoginAndRegister(
                    text: 'لدي حساب؟',
                    textOfButton: 'سجل دخول',
                    onPressed: () {
                      AppNavigations.pushReplacementTo(
                        context,
                        AppRoutes.login,
                        extra: userTypeEnum,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
