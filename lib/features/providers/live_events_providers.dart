import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/live_admin_services.dart';
import '../services/live_admin_services.dart';

final liveEventsProvider = StreamProvider<List<LiveEvent>>((ref) {
  return FirebaseFirestore.instance
      .collection('live_events')
      .where('status', isEqualTo: 'live')
      .where('isVisible', isEqualTo: true)
      .snapshots()
      .map(
        (snapshot) =>
        snapshot.docs.map(LiveEvent.fromFirestore).toList(),
  );
});

final upcomingEventsProvider = StreamProvider<List<LiveEvent>>((ref) {
  return FirebaseFirestore.instance
      .collection('live_events')
      .where('status', isEqualTo: 'upcoming')
      .where('isVisible', isEqualTo: true)
      .orderBy('startTime')
      .snapshots()
      .map(
        (snapshot) =>
        snapshot.docs.map(LiveEvent.fromFirestore).toList(),
  );
});
