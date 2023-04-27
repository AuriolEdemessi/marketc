import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';


import '../../../export.dart';
import 'chat_bubble.dart';

Widget messageWidget(ChatBubble chatBubble) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      chatBubble.isCurrentUser! ? 64.0 : 16.0,
      4,
      chatBubble.isCurrentUser! ? 16.0 : 64.0,
      4,
    ),
    child: Align(
      alignment: chatBubble.isCurrentUser!
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: chatBubble.isCurrentUser!
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.primary,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(chatBubble.text!, style: kSubtitle2.copyWith(color: chatBubble.isCurrentUser!
                  ? AppColors.black
                  : AppColors.white,)).paddingOnly(right: 24),
            //  Text(chatBubble.text!, style: customTextStyle(AppColors.kDark, FontSizes.s14)).paddingOnly(right: 24),
              Text(chatBubble.time!, style: kSubtitle2.copyWith(color: chatBubble.isCurrentUser!
                  ? AppColors.black
                  : AppColors.white,),)
              //Text(chatBubble.time!, style: customTextStyle(AppColors.kDarkmood, FontSizes.s12),)
            ],
          ),
        ),
      ),
    ),
  );
}
