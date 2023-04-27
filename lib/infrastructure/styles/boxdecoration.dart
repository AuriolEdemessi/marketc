import 'package:flutter/material.dart';

import 'colors.dart';
import 'size.dart';

BoxDecoration get boxDecoration {
  return BoxDecoration(
    border: Border.all(color: AppColors.black),
    borderRadius: BorderRadius.circular(RadiusSizes.r20),
  );
}
