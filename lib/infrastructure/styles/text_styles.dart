import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'size.dart';

final TextStyle kHeading1 = GoogleFonts.montserrat(fontSize: FontSizes.s30, fontWeight: FontWeight.w700, color: AppColors.black);
final TextStyle kHeading2 = GoogleFonts.montserrat(fontSize: FontSizes.s25, fontWeight: FontWeight.w600, color: AppColors.black);
final TextStyle kHeading3 = GoogleFonts.montserrat(fontSize: FontSizes.s20, fontWeight: FontWeight.w500, color: AppColors.black);
final TextStyle kHeading4 = GoogleFonts.montserrat(fontSize: FontSizes.s17, fontWeight: FontWeight.w500, color: AppColors.black);
final TextStyle kSubtitle1 = GoogleFonts.montserrat(fontSize: FontSizes.s14, fontWeight: FontWeight.w500, color: AppColors.black);
final TextStyle kSubtitle2 = GoogleFonts.montserrat(fontSize: FontSizes.s12, fontWeight: FontWeight.w500, color: AppColors.black);

final kTextTheme = TextTheme(
  headline1: kHeading1,
  headline2: kHeading2,
  headline3: kHeading3,
  headline4: kHeading4,
  subtitle1: kSubtitle1,
  subtitle2: kSubtitle2,
);
