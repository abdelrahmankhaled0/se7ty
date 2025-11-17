import 'package:flutter/material.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField({
    super.key,
    required this.emailController,
    this.validator,
    required this.text,
    required this.prefixIcon,
  });

  final TextEditingController emailController;
  final String? Function(String?)? validator;
  final String text;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.secondryColor.withValues(alpha: 0.6),
        suffixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        hint: Row(
          children: [
            Spacer(),
            Text(
              textAlign: TextAlign.left,
              text,
              style: AppTextStyle.textStyle16.copyWith(
                color: AppColors.grayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
