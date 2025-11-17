import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigations {
  static pushTo(BuildContext context, String newScreen, {Object? extra}) {
    context.push(newScreen, extra: extra);
  }

  static pushReplacementTo(
    BuildContext context,
    String newScreen, {
    Object? extra,
  }) {
    context.pushReplacement(newScreen, extra: extra);
  }

  static pop(BuildContext context) {
    context.pop();
  }
}
