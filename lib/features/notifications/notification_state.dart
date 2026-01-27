import 'package:despo/features/notifications/notification_model.dart';

class NotificationState {
  final bool isLoading;
  final List<AppNotification> notifications;
  final String? error;

  final Map<String, bool> readState;

  const NotificationState({
    required this.isLoading,
    this.error,
    required this.notifications,
    required this.readState,

});



  factory NotificationState.initial() {
    return const NotificationState(isLoading: false, error: null, notifications: [], readState: {});
  }

  NotificationState copyWith ({
    bool? isLoading,
    List<AppNotification>? notifications,
    String? error,
    Map<String, bool>? readState,
}){
    return NotificationState(isLoading:  isLoading ?? this.isLoading, error: error, notifications: notifications ?? this.notifications, readState: readState ?? this.readState);
  }
}