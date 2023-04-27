import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceWidth extends StatelessWidget {
 final double width;
   const SpaceWidth(this.width, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.toDouble().w,
    );
  }
}

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight(this.height, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.toDouble().h,
    );
  }
}
