// ignore_for_file: prefer_const_constructors

import 'package:fixa/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: whiteColor,
      fontFamily: 'circular-std',
      appBarTheme: AppBarTheme(backgroundColor: whiteColor, elevation: 0.0));
}
