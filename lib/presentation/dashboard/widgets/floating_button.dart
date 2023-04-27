import 'package:flutter/material.dart';

import '../../../export.dart';

import 'dart:math' as math;


class FloatingButtonView extends StatefulWidget {
  final Function()? addClick;
  const FloatingButtonView({Key? key, required this.addClick}) : super(key: key);

  @override
  FloatingButtonViewState createState() => FloatingButtonViewState();
}
class FloatingButtonViewState extends State<FloatingButtonView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationControllerButton;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationControllerButton = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationControllerButton.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 38 * 2.0,
      height: 38 + 62.0,
      child: Container(
       alignment: Alignment.topCenter,
        color: Colors.transparent,
        child: SizedBox(
          width: 38 * 2.0,
          height: 38 * 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScaleTransition(
              alignment: Alignment.center,
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationControllerButton, curve: Curves.fastOutSlowIn)),
              child:  Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  gradient:  const LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        offset: const Offset(8.0, 16.0),
                        blurRadius: 16.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white.withOpacity(0.1),
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: widget.addClick,
                    child: SizedBox(height: 10, width: 10, child: Image.asset("assets/images/ic_financial.png",))

                    /*Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 32,
                    ),*/
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}