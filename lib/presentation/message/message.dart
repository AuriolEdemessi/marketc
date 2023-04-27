import 'package:marketscc/presentation/message/single_message.dart';
import 'package:marketscc/presentation/message/widget/menu_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widget/constant.dart';
import 'widget/item_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  //late AppNotifier appNotifier;

  @override
  void initState() {
    //appNotifier = Provider.of<AppNotifier>(context, listen: false);

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
           /* Align(
              alignment: const Alignment(0.5, -0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 *//* SvgPicture.asset(AppSvg.svgPath("ic_chevron_left")),
                  Text(
                    "Message",
                    style: customTextStyle(AppColors.kDark, FontSizes.s20,
                        fontWeight: FontWeight.w500),
                  ),
                  SvgPicture.asset(AppSvg.svgPath("ic_search")),*//*
                ],
              ).paddingOnly(left: 20, right: 20, top: 10),
            ),*/
            Positioned.fill(
                top: 70,
                child: ListView.builder(
                    itemCount: listMessage.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return SlideMenu(
                        child: SizedBox(
                          height: 70,
                          child:GestureDetector(onTap: (){
                            Get.to(()=>const SingleMessageScreen());
                          }, child: itemMessage(listMessage[index]).paddingOnly(left: 20, right: 20))),
                        menuItems: <Widget>[
                         /* GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(AppSvg.svgPath("ic_trash")),
                          )*/
                        ],
                      );
                    }))
          ],
        ),
      );
  }

}
