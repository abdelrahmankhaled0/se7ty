import 'package:flutter/material.dart';
import 'package:se7ty/features/auth/data/models/doctor_specializations.dart';

class ColorPair {
  final Color primary;
  final Color light;

  ColorPair(this.light, this.primary);
}

ColorPair blue = ColorPair(Color(0xff71b4fb), Color(0xff7fbcfb));
ColorPair orange = ColorPair(Color(0xfffa8c73), Color(0xfffa9881));
ColorPair purple = ColorPair(Color(0xff8873f4), Color(0xff9489f4));
ColorPair green = ColorPair(Color(0xff4cd1bc), Color(0xff5ed6c3));

class SpecializationCardModel {
  final String specialization;
  final ColorPair colorPair;

  SpecializationCardModel(this.colorPair, {required this.specialization});
}

final List<SpecializationCardModel> specializationList = List.generate(
  specializations.length,
  (index) {
    final colorPair = getColorPair(index);
    return SpecializationCardModel(
      colorPair,
      specialization: specializations[index],
    );
  },
);

ColorPair getColorPair(int index) {
  switch (index % 4) {
    case 0:
      return blue;
    case 1:
      return orange;
    case 2:
      return purple;
    case 3:
      return green;
    default:
      return blue;
  }
}
