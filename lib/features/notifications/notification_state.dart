import 'package:despo/features/notifications/notification_model.dart';

class NotificationState {
  final bool isLoading;
  final List<AppNotification> notifications;
  final String? error;

  const NotificationState({
    required this.isLoading,
    required this.error,
    required this.notifications

});

  factory NotificationState.initial() {
    return const NotificationState(isLoading: false, error: null, notifications: []);
  }

  NotificationState copyWith ({
    bool? isLoading,
    List<AppNotification>? notifications,
    String? error,
}){
    return NotificationState(isLoading:  isLoading ?? this.isLoading, error: error ?? this.error, notifications: notifications ?? this.notifications);
  }
}