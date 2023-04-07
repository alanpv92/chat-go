import 'dart:math';
import 'dart:developer' as dev;
import 'package:app_settings/app_settings.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';

import '../../data/models/chat_preview.dart';
import '../../ui/screens/chat.dart';

@pragma('vm:entry-point')
Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class NotificationService {
  NotificationService._();
  static NotificationService instance = NotificationService._();
  factory NotificationService() => instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initLocalNotifications(RemoteMessage message) async {
    var andriodInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosIntializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: andriodInitializationSettings, iOS: iosIntializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (details) {
        ChatPreview chatPreview = ChatPreview(
            receiverName: message.notification!.title!,
            receiverid: message.data['reciever_id'],
            lastMessage: message.notification!.body!);
        Get.to(() => ChatScreen(chatPreview: chatPreview));
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(100000).toString(),
            'High Importance Notifications',
            
            importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: '',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    dev.log(message.data.toString());
    _flutterLocalNotificationsPlugin.show(0, message.notification!.title,
        message.notification!.body, notificationDetails);
  }

  initFirebaseNotifications() {
    FirebaseMessaging.onMessage.listen((event) async {
      await initLocalNotifications(event);
      showNotification(event);
    });
  }

  requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
      await AppSettings.openNotificationSettings();
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();

    return token;
  }
}
