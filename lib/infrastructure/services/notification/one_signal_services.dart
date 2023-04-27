import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../export.dart';
import '../../utils/app_key.dart';

NotificationService notificationService = NotificationService();

Future<void> oneSignalServices() async {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(OneSignalAppId);

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) async {
    print("Accepted permission: $accepted");
  });

  final status = await OneSignal.shared.getDeviceState();

  await hive.saveOsUserID(status?.userId);

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) async {
// Will be called whenever a notification is received in foreground
// Display Notification, pass null param for not displaying the notification

    //print("notification receveid notification===>${event}");

/*    await notificationService.showLocalNotification(
        id: 0,
        title: "Drink Water",
        body: "Time to drink some water!",
        payload: "You just took water! Huurray!");*/

    event.complete(event.notification);
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
// Will be called whenever a notification is opened/button pressed.
  });

  OneSignal.shared
      .setPermissionObserver((OSPermissionStateChanges changes) async {
// Will be called whenever the permission changes
// (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
// Will be called whenever the subscription changes
// (ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver(
      (OSEmailSubscriptionStateChanges emailChanges) {
// Will be called whenever then user's email subscription changes
// (ie. OneSignal.setEmail(email) is called and the user gets registered
  });
}
