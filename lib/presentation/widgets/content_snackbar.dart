import 'package:flutter/material.dart';

import '../../export.dart';

/*
class ContentSnackBar extends StatelessWidget {
  final String message;
  final Color? color;
  const ContentSnackBar({
    Key? key,
    required this.message,
     this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 80.h,
          decoration:  BoxDecoration(
            color: color?? AppColors.error,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text(
                'Message',
                style: TextStyle(
                    fontSize: 18, color: Colors.white),
              ),
              Text(message,
                style: const TextStyle(
                    fontSize: 14, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Positioned(
            top: -20,
            left: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: color?? Colors.red,
                    borderRadius:
                    BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                const Positioned(
                    top: 5,
                    child: Icon(
                      Icons.clear_outlined,
                      color: Colors.white,
                      size: 20,
                    ))
              ],
            )),
      ],
    );
  }
}*/
