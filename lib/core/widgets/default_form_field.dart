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
    this.suffixIcon,
    this.onSuffixPressed,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final TextEditingController emailController;
  final String? Function(String?)? validator;
  final String text;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int? maxLines;
  final Function()? onTap;
  final Function()? onSuffixPressed;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      controller: emailController,
      validator: validator,
      maxLines: maxLines,
      textInputAction: textInputAction,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.secondryColor.withValues(alpha: 0.6),
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        suffixIcon: IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(suffixIcon, color: AppColors.primaryColor),
        ),
        hintText: text,
        hintStyle: TextStyle(color: AppColors.grayColor),
      ),
    );
  }
}
