import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

AppBar CustomAppBar({bool showBack = true}){
  return AppBar(backgroundColor: AppColors.primary,
    automaticallyImplyLeading: showBack,
    actions: [
      IconNotification()
      /*IconButton(onPressed: (){
        Get.to(()=>NotificationPage());
      }, icon: const Icon(Icons.notification_add_outlined),)*/
    ],);
}

class IconNotification extends StatefulWidget {
  const IconNotification({Key? key}) : super(key: key);

  @override
  State<IconNotification> createState() => _IconNotificationState();
}

class _IconNotificationState extends State<IconNotification> {

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: EdgeInsets.only(right: 10,top: 10),
      alignment: Alignment.center,
      width: 30,
      height: 30,
      child: InkWell(
        onTap: (){
          Get.to(()=>NotificationPage());
        },
        child: Stack(
          children: [
            Icon(Icons.notifications),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 5),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      "${context.read<NotificationCubit>().notifUnread.value}",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )) /*Stack(
      children: [
        IconButton(onPressed: (){
          Get.to(()=>NotificationPage());
        }, icon: const Icon(Icons.notification_add_outlined),)
      ],
    )*/;
  }
}
