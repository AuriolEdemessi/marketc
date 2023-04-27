import 'dart:math';
import 'package:marketscc/infrastructure/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'message.dart';

Widget itemMessage(Message message) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 40,
        width: 40,
        child: message.user!.image!.isEmpty
            ? getLeadingWidget(message.user!.fname!)
            : ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(30), // Image radius
                  child: Image.asset("", fit: BoxFit.cover),
                ),
              ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${message.user!.fname} ${message.user!.lname}", style: kHeading4,),
            //Text("${message.user!.firstname} ${message.user!.lastname}", style: customTextStyle(AppColors.kDark, FontSizes.s16, fontWeight: FontWeight.w500),),
            Text("${message.lastMessage}", overflow: TextOverflow.ellipsis, style: kSubtitle2),
           // Text("${message.lastMessage}", overflow: TextOverflow.ellipsis, style: customTextStyle(AppColors.kGrey, FontSizes.s14)),
          ],
        ).paddingOnly(left: 15),
      ),
      message.unread!?Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            "${message.number!}",
            style: kSubtitle2,
           // style: customTextStyle(AppColors.kWhite, FontSizes.s10, fontWeight: FontWeight.w500),
          ),
        ),
      ):Container(),
    ],
  );
}

CircleAvatar getLeadingWidget(currencyName) {
  return CircleAvatar(
    backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.5),
    child: Text(currencyName[0], style: kSubtitle1,),
  //  child: Text(currencyName[0], style: customTextStyle(AppColors.kBlack, FontSizes.s14),),
  );
}
