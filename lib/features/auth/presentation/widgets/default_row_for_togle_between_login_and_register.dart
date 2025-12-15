import 'package:flutter/material.dart';
import 'package:se7ty/core/utils/app_colors.dart';
import 'package:se7ty/core/utils/app_text_style.dart';

class DefaultRowForTogleBetweenLoginAndRegister extends StatelessWidget {
  const DefaultRowForTogleBetweenLoginAndRegister({
    super.key,
    required this.text,
    required this.textOfButton,
    required this.onPressed,
  });

  final String text;
  final String textOfButton;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textOfButton,
            style: AppTextStyle.textStyle14.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
