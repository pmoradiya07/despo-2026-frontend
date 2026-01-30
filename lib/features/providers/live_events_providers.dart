import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/live_admin_services.dart';


final timeTickerProvider = StreamProvider<DateTime>((ref) {
  return Stream.periodic(
    const Duration(seconds: 30),
    (_) => DateTime.now(),
  );
});

final allLiveEventsProvider = StreamProvider<List<LiveEvent>>((ref) {
  return FirebaseFirestore.instance
      .collection('live_events')
      .where('isVisible', isEqualTo: true)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map(LiveEvent.fromFirestore).toList(),
      );
});

final liveEventsProvider = Provider<AsyncValue<List<LiveEvent>>>((ref) {
  final eventsAsync = ref.watch(allLiveEventsProvider);
  ref.watch(timeTickerProvider); // forces recompute

  return eventsAsync.whenData(
    (events) => events
        .where(
          (e) => e.computedStatus == ComputedEventStatus.live,
        )
        .toList(),
  );
});

final upcomingEventsProvider = Provider<AsyncValue<List<LiveEvent>>>((ref) {
  final eventsAsync = ref.watch(allLiveEventsProvider);
  ref.watch(timeTickerProvider); // forces recompute

  return eventsAsync.whenData(
    (events) => events
        .where(
          (e) => e.computedStatus == ComputedEventStatus.upcoming,
        )
        .toList()
      ..sort(
        (a, b) => a.startTime.compareTo(b.startTime),
      ),
  );
});
