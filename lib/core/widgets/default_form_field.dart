import 'package:flutter/material.dart';
import 'package:se7ty/core/utils/app_colors.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField({
    super.key,
    required this.emailController,
    this.validator,
    required this.text,
    this.prefixIcon,
    this.maxLines,
    this.onTap,
  });

  final TextEditingController emailController;
  final String? Function(String?)? validator;
  final String text;
  final IconData? prefixIcon;
  final int? maxLines;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: emailController,
      validator: validator,
      maxLines: maxLines,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.secondryColor.withValues(alpha: 0.6),
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        hintText: text,
        hintStyle: TextStyle(color: AppColors.grayColor),
      ),
    );
  }
}
