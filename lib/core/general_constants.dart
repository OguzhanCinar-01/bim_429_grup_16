import 'package:flutter/material.dart';

class GeneralConstants {
  static GeneralConstants? _instance;
  static GeneralConstants get instance {
    _instance ??= GeneralConstants._init();
    return _instance!;
  }

  GeneralConstants._init();

  final heightExtraLarge = 100.0; // 100.0
  final heightLarge = 80.0; // 80.0
  final heightMedium = 60.0; // 60.0
  final heightSmall = 40.0; // 40.0
  final heightExtraSmall = 20.0; // 20.0

  final borderRadius = BorderRadius.circular(8); // 8
  final radius = const Radius.circular(32);
  final outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(32),
  );

  final boxShadow = const BoxShadow(
    color: Colors.black12,
    blurRadius: 10,
    spreadRadius: 1,
    offset: Offset(0, 1),
  );

  final fontSizeExtraSmall = 12.0; // 12.0
  final fontSizeSmall = 14.0; // 16.0
  final fontSizeMedium = 18.0; // 20.0
  final fontSizeLarge = 22.0; // 24.0
  final fontSizeExtraLarge = 28.0; // 28.0

  final fontWeightLight = FontWeight.w300; // w300
  final fontWeightRegular = FontWeight.w500; // w500
  final fontWeightBold = FontWeight.w700; // w700
}
