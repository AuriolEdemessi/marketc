import 'package:flutter/material.dart';
import '../../export.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String? text;
  final Color? background;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const ButtonWidget({
    Key? key,
    this.voidCallback,
    this.text,
    this.width,
    this.height,
    this.background,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??200,
      height: height??40,
      child:  ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(background),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: borderColor ?? background!,
                      )))),
              onPressed: voidCallback,
              child: Text(
                text ?? "",
                textAlign: TextAlign.center,
                 style: kSubtitle2.copyWith(fontWeight: FontWeight.w600, color: textColor??AppColors.white)
              ),
            ),
    );
  }
}
