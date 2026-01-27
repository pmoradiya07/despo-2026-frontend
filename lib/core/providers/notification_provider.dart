import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:despo/features/notifications/notification_state.dart';
import 'package:despo/features/notifications/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsNotifier extends Notifier<NotificationState> {
  final _firestore = FirebaseFirestore.instance;
  static const _readKey = 'read_notifications';

  @override
  NotificationState build() {
    _loadReadState();
    return NotificationState.initial();
  }

  Future<void> markAsRead(String notificationID) async {
    final updated = Map<String, bool>.from(state.readState);
    updated[notificationID] = true;

    state = state.copyWith(readState: updated);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _readKey,
      updated.keys.toList(),
    );
  }

  Future<void> _loadReadState() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_readKey) ?? [];

    final map = {
      for (final id in ids)
        id: true
    };

    state = state.copyWith(readState: map);
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
}

final notificationsProvider =
NotifierProvider<NotificationsNotifier, NotificationState>(
  NotificationsNotifier.new,
);
