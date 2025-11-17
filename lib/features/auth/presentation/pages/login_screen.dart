import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:se7ty/core/constants/app_images.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';
import 'package:se7ty/core/widgets/default_form_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image(
              image: AssetImage(AppImages.logoImage),
              width: MediaQuery.sizeOf(context).width * 0.5,
            ),
            Gap(10),
            Text(
              'سجل الدخول الان كـ "" ',
              style: AppTextStyle.textStyle20.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(30),
            DefaultFormField(
              emailController: emailController,
              text: 'abdelrahman@example.com',
              prefixIcon: Icons.email,
              validator: (value) {
                return;
              },
            ),
            Gap(20),
            DefaultFormField(
              emailController: passwordController,
              text: '*******************',
              prefixIcon: Icons.lock,
            ),
          ],
        ),
      ),
    );
  }
}
