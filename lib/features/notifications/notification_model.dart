import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
});

  factory AppNotification.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data() ?? {};

    return AppNotification(
      id: doc.id,
      title: (data['title'] ?? '') as String,
      message: (data['body'] ?? '') as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }

}