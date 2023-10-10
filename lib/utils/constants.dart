import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const brickColorPrimary = Color(0xff17A4DD);
  static const brickColorSecondary = Color(0xff56647D);
  static const backgroundColor = Color(0xff2F3B52);
  static const playerColor = Color(0xffffffff);
  static const greenColor = Color(0xff39805B);
}

class AppFonts {
  static TextStyle playBtnStyle = GoogleFonts.russoOne(
    fontSize: 30.0,
    fontWeight: FontWeight.w400,
    height: 0.36,
    color: AppColors.greenColor,
  );
}
