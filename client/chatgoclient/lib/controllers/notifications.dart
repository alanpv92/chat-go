import 'dart:developer';

import 'package:chatgoclient/controllers/user_mangement.dart';
import 'package:chatgoclient/data/custom%20types/custom_types.dart';
import 'package:chatgoclient/data/models/chat_preview.dart';
import 'package:chatgoclient/services/network/hasura/notification.dart';
import 'package:chatgoclient/services/notifications/notification.dart';
import 'package:chatgoclient/ui/screens/chat.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/route_manager.dart';

class NotificationController {
  NotificationController._();
  static NotificationController instance = NotificationController._();
  factory NotificationController() => instance;
  final NotificationService _notificationService = NotificationService();
  final NotificationHasuraService _notificationHasuraService =
      NotificationHasuraService();

  initFirebaseNotifications() async {
    await NotificationService.instance.requestNotificationPermission();
    await initFirebaseNotificationTokens();
    await NotificationService.instance.initFirebaseNotifications();
  }

  initFirebaseNotificationTokens() async {
    try {
      final String? token = await _notificationService.getDeviceToken();

      if (token != null) {
        final response = await _notificationHasuraService.getUserToken(
            userId: UserMangementController.instance.user.userId);

        await response.fold((l) async {
          //handle error case
          return;
        }, (r) async {
          log(r.toString());
          final userNotificationToken = r['usernotifications'] as List;
          if (userNotificationToken.isEmpty) {
            await _notificationHasuraService.insertUserNotificationToken(
                userId: UserMangementController.instance.user.userId,
                token: token);
          } else {
            if (userNotificationToken[0]['notification_token'] != token) {
              await _notificationHasuraService.updateUserNotificationToken(
                  userId: UserMangementController.instance.user.userId,
                  token: token);
            }
          }
        });
      }
    } catch (e) {
      log('Notifiaction init error');
    }
  }

  checkForNotification() async {
    RemoteMessage? intialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (intialMessage != null) {
      ChatPreview chatPreview = ChatPreview(
          receiverName: intialMessage.notification!.title!,
          receiverid: intialMessage.data['reciever_id'],
          lastMessage: intialMessage.notification!.body!);
      Get.to(() => ChatScreen(chatPreview: chatPreview));
    }
  }

  Future<HasuraResponse> removeNotificationToken() async {
    final response =
        await _notificationHasuraService.removeUserNotificationToken(
            userId: UserMangementController.instance.user.userId);
    return response;
  }
}
