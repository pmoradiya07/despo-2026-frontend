import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:despo/features/notifications/notification_state.dart';
import 'package:despo/features/notifications/notification_model.dart';

class NotificationsNotifier extends Notifier<NotificationState> {
  final _firestore = FirebaseFirestore.instance;

  @override
  NotificationState build() {
    return NotificationState.initial();
  }

  Future<void> fetchNotifications() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final snapshot = await _firestore
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .get();

      final notifications = snapshot.docs
          .map((doc) => AppNotification.fromFirestore(doc))
          .toList();

      state = state.copyWith(
        isLoading: false,
        notifications: notifications,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markAsRead(String notificationID) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(notificationID)
          .update({'read' : true});
    } catch (e) {
      print(e.toString());
    }
  }
}

final notificationsProvider =
NotifierProvider<NotificationsNotifier, NotificationState>(
  NotificationsNotifier.new,
);
