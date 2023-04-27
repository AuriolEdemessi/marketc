import 'package:marketscc/presentation/message/widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../export.dart';
import 'widget/message_widget.dart';

class SingleMessageScreen extends StatefulWidget {
  const SingleMessageScreen({Key? key}) : super(key: key);

  @override
  SingleMessageScreenState createState() => SingleMessageScreenState();
}

class SingleMessageScreenState extends State<SingleMessageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_outlined),
            )
          ],
        ),
        backgroundColor: AppColors.white,
        bottomNavigationBar: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset("assets/icons/ic_plus.svg"),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.primary, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: 278,
                child: TextField(
                     maxLines: 6,
                    minLines: 1,
                    // controller: emailTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
                      hintText: "Type a message",
                      suffixIcon: SvgPicture.asset("assets/icons/ic_send.svg", color: AppColors.primary).paddingOnly(right: 20),
                      border: InputBorder.none,
                    ))).paddingOnly(left: 11),
          ],
        ).paddingOnly(left: 20, right: 20, bottom: 10, top: 10),
        body: ListView.builder(
            itemCount: listChatBubble.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return messageWidget(listChatBubble[index]);
            }));
  }
}
