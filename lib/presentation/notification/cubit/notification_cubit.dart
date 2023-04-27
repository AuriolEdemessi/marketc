import 'package:dio/dio.dart';
import 'package:get/get.dart' as getX;

import '../../../export.dart';

class NotificationCubit extends Cubit<NotificationState> {

  final HomeScreenUseCase useCase;

  NotificationCubit(this.useCase) : super(NotificationState());

  getX.RxInt notifUnread = 0.obs;

  Future<void> unreadNotif() async {
    BaseApiClient baseApiClient = BaseApiClient();
    Response response = await baseApiClient.get(pathUrl: "notification/history/NEW");
    notifUnread(response.data['Total_notification_new']);
  }

  Future<List<MesNotificationModel>> fetch(page) async {
    BaseApiClient baseApiClient = BaseApiClient();
    Response response = await baseApiClient.get(
        pathUrl: "notification/history/ALL?page=$page");
        //pathUrl: "notification/history?page=$page");
    notifUnread(response.data['Total_notification_new']);
    return NotificationResponse.fromJson(response.data['data']['data'], ).notificationList;
  }

  Future<void> notificationRead(id) async {
    BaseApiClient baseApiClient = BaseApiClient();
    await baseApiClient.put(pathUrl: "notification/read/$id");

  }
}
