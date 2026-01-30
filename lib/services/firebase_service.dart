import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

import '../features/notifications/notification_bridge_stub.dart' if (dart.library.io) '../features/notifications/notification_bridge_mobile.dart';



class FirebaseService {
  static final _messaging = FirebaseMessaging.instance;
  static final _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _messaging.requestPermission();
    
    if (!kIsWeb) {
      const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      const initSettings =
      InitializationSettings(android: androidSettings);

      await _localNotifications.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (details) {},
      );
    }

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);


    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final data = message.data;
      final notificationId = data['notificationId'];

      if (notificationId != null && notificationId is String) {
        NotificationsBridge.onRemoteNotification(notificationId);
      }
    });

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      final data = initialMessage.data;
      final notificationId = data['notificationId'];

      if (notificationId != null && notificationId is String) {
        NotificationsBridge.onRemoteNotification(notificationId);
      }
    }
  }

  static Future<void> _handleForegroundMessage(
      RemoteMessage message) async {

    final data = message.data;
    final notificationID = data['notificationId'];

    if(notificationID != null) NotificationsBridge.onRemoteNotification(notificationID);



    final notification = message.notification;
    if (notification == null) return;

    // Only show local notifications on non-web platforms
    if (!kIsWeb) {
      const androidDetails = AndroidNotificationDetails(
        'default_channel',
        'Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const details = NotificationDetails(android: androidDetails);

      await _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: details,
      );
    }
  }
}

// ⚠️ Must be top-level
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  // No logic yet — required for Android
}
