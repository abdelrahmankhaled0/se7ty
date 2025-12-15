import 'package:flutter/material.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.foregroundColor = AppColors.lightColor,
  });

  final String text;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyle.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
