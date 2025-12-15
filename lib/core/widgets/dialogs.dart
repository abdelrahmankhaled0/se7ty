import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ty/core/utils/app_colors.dart';

enum DialogType { succes, error, info }

showMyDialog(
  BuildContext context,
  String message, [
  DialogType dialogType = DialogType.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: dialogType == DialogType.error
          ? AppColors.redColor
          : dialogType == DialogType.info
          ? Colors.yellow
          : AppColors.primaryColor,
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: AppColors.darkColor.withValues(alpha: 0.8),
    barrierDismissible: false,
    builder: (context) {
      return Center(child: Lottie.asset("assets/images/loading.json"));
    },
  );
}
