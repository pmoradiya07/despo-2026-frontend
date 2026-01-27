import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:despo/core/providers/notification_provider.dart';

class NotificationsBridge {
  static ProviderContainer? _container;

  static void register(ProviderContainer container) {
    _container = container;
  }

  static void onRemoteNotification(String notificationId) {
    _container
        ?.read(notificationsProvider.notifier)
        .fetchNotifications();
  }
}
