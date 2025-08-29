import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:waslny_pusher_test_driver/core/services/background_service.dart';
import 'package:waslny_pusher_test_driver/presentation/controllers/notification_controller.dart';

class FcmNotifications extends GetxService {
  static const String key = 'notification_status';

  // static Future<bool> getNotificationStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(key) ??
  //       true; // Return true by default if the value is not set
  // }

  // static Future<void> setNotificationStatus(bool status) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(key, status);
  // }

  @override
  void onInit() async {
    // await fcmHandler();
    super.onInit();

    // await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // @pragma('vm:entry-point')
  // Future<void> sendNotification({
  //   required List<String> fcmTokens,
  //   required String title,
  //   required String body,
  //   required NotificationType type,
  //   Map<String, String>? data,
  // }) async {
  //   Map<String, String> insidedata = <String, String>{};
  //   insidedata.addAll({
  //     'type': type.name,
  //   });
  //   if (data != null) {
  //     insidedata.addAll(data);
  //   }
  //   await NotificationController.sendPushMessage(
  //     fcmTokens: fcmTokens,
  //     title: title,
  //     body: body,
  //     data: insidedata,
  //   );
  // }

  // @pragma('vm:entry-point')
  // Future<void> sendNotificationAsJson({
  //   required List<String> fcmTokens,
  //   required String title,
  //   required String body,
  //   required NotificationType type,
  //   Map<String, String>? data,
  // }) async {
  //   Map<String, dynamic> dataJson = initializeJson(
  //     type: type,
  //     body: body,
  //     data: data,
  //     title: title,
  //   );
  //   await NotificationController.sendPushMessageJson(
  //       data: dataJson, fcmTokens: fcmTokens);
  // }

  // static Map<String, dynamic> initializeJson({
  //   Map<String, String>? data,
  //   required String title,
  //   required String body,
  //   required NotificationType type,
  // }) {
  //   Map<String, dynamic> insidedata = <String, dynamic>{};
  //   NotificationContent content =
  //       getContent(title: title, body: body, type: type, data: data);
  //   List<Map<String, dynamic>> button =
  //       FcmNotifications.getButtonsByNotificationType(type: type);
  //   insidedata.addAll({
  //     "notification": {
  //       "content": content.toMap(),
  //       "actionButtons": button,
  //     }
  //   });
  //   return insidedata;
  // }

  static NotificationContent getContent({
    Map<String, String>? data,
    required String title,
    required String body,
  }) {
    Random random = Random();
    NotificationContent content = NotificationContent(
      id: random.nextInt(999),
      channelKey: getChannelByType(),
      title: title,
      body: body,
      criticalAlert: true,
      wakeUpScreen: true,
      payload: data,
      displayOnForeground: true,
      displayOnBackground: true,
      // customSound: 'resource://raw/${getSoundByType(notificationType: type)}',
    );
    // the Developer karem saad
    return content;
  }

  static String getChannelByType() {
    return "high_importance_channel";
  }

  static String getSoundByType() {
    return "pikachu";
  }

  @pragma('vm:entry-point')
  Future<void> fcmHandler() async {
    FirebaseMessaging.onMessage.listen(handleMessageJson);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageJson);
    FirebaseMessaging.onBackgroundMessage(handleMessageJson);
    RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      handleMessageJson(remoteMessage);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> handleMessage(RemoteMessage message) async {
    FcmNotifications notifications = Get.put(FcmNotifications());

    //we are converting the data which come from firestore as String,dynamic map
    //even if you are only sending String,String
    Map<String, String> datapayload =
        Map<String, String>.from(message.data.cast<String, String>());
    print(message.data);

    await notifications.showNotification(
      title: message.data["title"]!,
      body: message.data["body"]!!,
      // payload: datapayload,
      // buttons: buttons,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> handleMessageJson(RemoteMessage message) async {
    try {
      //we are converting the data which come from firestore as String,dynamic map
      //even if you are only sending String,String
      //  print(message.data["data"]);
      Logger logger = Logger();
      logger.e("recieved successfully");
      // logger.i(message.notification!.title!);
      logger.i(message.data);
      Map<String, dynamic> s = message.data;
      print(s);
      await NotificationController.showNotificationJson(s);
    } catch (e) {
      logger.e(e);
    }
  }

  // @pragma('vm:entry-point')
  // static List<Map<String, dynamic>> getButtonsByNotificationType(
  //     {required NotificationType type}) {
  //   //the buttons to show to the user depending on the type of the notification
  //   List<NotificationActionButton> buttons = [];

  //   //all notifications must have a button to just mark the notification as read

  //   //the key field allows us to handle the button click how we like with a function whatever
  //   print(type);
  //   switch (type) {
  //     case NotificationType.teamInvite:
  //       buttons.addAll([
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.acceptTeamInvite.name,
  //           label: 'accept',
  //           actionType: ActionType.KeepOnTop,
  //         ),
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.declineTeamInvite.name,
  //           label: 'decline Invite',
  //           actionType: ActionType.KeepOnTop,
  //           requireInputText: true,
  //         )
  //       ]);

  //       break;
  //     case NotificationType.taskRecieved:
  //       buttons.addAll([
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.acceptTask.name,
  //           label: 'accept',
  //           actionType: ActionType.KeepOnTop,
  //         ),
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.declineTask.name,
  //           label: 'decline',
  //           actionType: ActionType.KeepOnTop,
  //           requireInputText: true,
  //         )
  //       ]);
  //       break;
  //     case NotificationType.userTaskTimeFinished:
  //       buttons.addAll([
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.markUserTaskDone.name,
  //           label: 'done',
  //           actionType: ActionType.KeepOnTop,
  //         ),
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.markUserTaskNotDone.name,
  //           label: 'not done',
  //           actionType: ActionType.KeepOnTop,
  //         )
  //       ]);
  //       break;
  //     case NotificationType.memberTaskTimeFinished:
  //       buttons.addAll([
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.markSubTaskDone.name,
  //           label: AppConstants.done_key.tr,
  //           actionType: ActionType.KeepOnTop,
  //         ),
  //         NotificationActionButton(
  //           key: NotificationButtonskeys.markSubTaskNotDone.name,
  //           label: AppConstants.not_done_key.tr,
  //           actionType: ActionType.KeepOnTop,
  //           requireInputText: true,
  //         )
  //       ]);
  //       break;
  //     default:
  //   }

  //   buttons.add(
  //     NotificationActionButton(
  //       key: NotificationButtonskeys.markAsRead.name,
  //       label: NotificationButtonskeys.markAsRead.name,
  //       requireInputText: false,
  //       actionType: ActionType.DisabledAction,
  //     ),
  //   );
  //   List<Map<String, dynamic>> buttonMap = [];
  //   for (NotificationActionButton element in buttons) {
  //     buttonMap.add(element.toMap());
  //   }
  //   return buttonMap;
  // }

  @pragma('vm:entry-point')
  Future<void> showNotification({
    required String title,
    required String body,
    // required Map<String, String> payload,
    // List<NotificationActionButton>? buttons,
  }) async {
    await NotificationController.showNotification(
      title: title,
      body: body,
      // actionButtons: buttons,
      // payload: payload,
    );
  }

  // @pragma('vm:entry-point')
  // static Future<void> onActionReceivedMethod(
  //   ReceivedAction receivedAction,
  // ) async {
  //   UserTaskController userTaskController = Get.put(UserTaskController());
  //   StatusController statusController = Get.put(StatusController());
  //   NotificationButtonskeys type =
  //       NotificationButtonskeys.values.byName(receivedAction.buttonKeyPressed);
  //   switch (type) {
  //     case NotificationButtonskeys.markUserTaskDone:
  //       String taskId = receivedAction.payload!["id"]!;

  //       StatusModel statusModel =
  //           await statusController.getStatusByName(status: statusDone);
  //       userTaskController.updateUserTask(
  //           isfromback: true, data: {statusIdK: statusModel.id}, id: taskId);
  //       break;

  //     case NotificationButtonskeys.markUserTaskNotDone:
  //       String taskId = receivedAction.payload!["id"]!;
  //       StatusModel s =
  //           await statusController.getStatusByName(status: statusNotDone);
  //       userTaskController.updateUserTask(
  //           isfromback: true, data: {statusIdK: s.id}, id: taskId);
  //       break;

  //     case NotificationButtonskeys.acceptTeamInvite:
  //       String waitingMemberId = receivedAction.payload!["id"]!;
  //       WaitingMamberController waitingMamberController =
  //           Get.put(WaitingMamberController());
  //       await waitingMamberController.acceptTeamInvite(
  //           waitingMemberId: waitingMemberId);
  //       break;

  //     case NotificationButtonskeys.declineTeamInvite:
  //       String waitingMemberId = receivedAction.payload!["id"]!;
  //       WaitingMamberController waitingMamberController =
  //           Get.put(WaitingMamberController());
  //       String rejectingMessage = receivedAction.buttonKeyInput;

  //       await waitingMamberController.declineTeamInvite(
  //         waitingMemberId: waitingMemberId,
  //         rejectingMessage: rejectingMessage,
  //       );
  //       break;
  //     case NotificationButtonskeys.acceptTask:
  //       String waitingSubTaskId = receivedAction.payload!["id"]!;
  //       WatingSubTasksController watingSubTasksController =
  //           Get.put(WatingSubTasksController());
  //       await watingSubTasksController.accpetSubTask(
  //         waitingSubTaskId: waitingSubTaskId,
  //       );
  //       break;

  //     case NotificationButtonskeys.declineTask:
  //       String waitingSubTaskId = receivedAction.payload!["id"]!;
  //       WatingSubTasksController watingSubTasksController =
  //           Get.put(WatingSubTasksController());
  //       String rejectingMessage = receivedAction.buttonKeyInput;
  //       await watingSubTasksController.rejectSubTask(
  //           waitingSubTaskId: waitingSubTaskId,
  //           rejectingMessage: rejectingMessage);
  //       break;

  //     case NotificationButtonskeys.markSubTaskDone:
  //       String subtaskId = receivedAction.payload!["id"]!;

  //       ProjectSubTaskController projectSubTaskController =
  //           Get.put(ProjectSubTaskController());
  //       projectSubTaskController.markSubTaskeAndSendNotification(
  //           subtaskId, statusDone);
  //       break;
  //     case NotificationButtonskeys.markSubTaskNotDone:
  //       String subtaskId = receivedAction.payload!["id"]!;

  //       ProjectSubTaskController projectSubTaskController =
  //           Get.put(ProjectSubTaskController());
  //       projectSubTaskController.markSubTaskeAndSendNotification(
  //           subtaskId, statusNotDone);
  //       break;
  //     default:
  //   }
  // }
}
