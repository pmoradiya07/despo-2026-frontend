import 'package:cloud_firestore/cloud_firestore.dart';

/// =======================
/// ENUMS & CONSTANTS
/// =======================

enum EventStatus { upcoming, live, ended }

extension EventStatusX on EventStatus {
  String get value => name;

  static EventStatus fromString(String value) {
    return EventStatus.values.firstWhere(
          (e) => e.name == value,
      orElse: () => EventStatus.upcoming,
    );
  }
}

const List<String> allowedSports = [
  'football',
  'badminton',
  'volleyball',
  'basketball',
  'tabletennis',
  'lawntennis',
  'squash',
  'kabaddi',
  'futsal',
  'chess',
  'cricket',
  'marathon',
];

/// =======================
/// MODEL
/// =======================

class LiveEvent {
  final String id;
  final String sport;
  final String title;
  final String teamA;
  final String teamB;
  final DateTime startTime;
  final DateTime endTime;
  final String status;
  final String venue;
  final bool isVisible;

  LiveEvent({
    required this.id,
    required this.sport,
    required this.title,
    required this.teamA,
    required this.teamB,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.venue,
    required this.isVisible,
  });

  factory LiveEvent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return LiveEvent(
      id: doc.id,
      sport: data['sport'],
      title: data['title'],
      teamA: data['teamA'],
      teamB: data['teamB'],
      startTime: (data['startTime'] as Timestamp?)?.toDate()
          ?? DateTime.fromMillisecondsSinceEpoch(0),

      endTime: (data['endTime'] as Timestamp?)?.toDate()
          ?? DateTime.fromMillisecondsSinceEpoch(0),

      status: data['status'],
      venue: data['venue'],
      isVisible: data['isVisible'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sport': sport,
      'title': title,
      'teamA': teamA,
      'teamB': teamB,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'status': status,
      'venue': venue,
      'isVisible': isVisible,
    };
  }
}

/// =======================
/// SERVICE (ADMIN ONLY)
/// =======================

class LiveEventAdminService {
  LiveEventAdminService._();
  static final LiveEventAdminService instance =
  LiveEventAdminService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _ref =>
      _firestore.collection('live_events');

  /// -----------------------
  /// VALIDATION
  /// -----------------------

  void _validateEvent(LiveEvent event) {
    if (!allowedSports.contains(event.sport)) {
      throw Exception('Invalid sport type');
    }

    if (event.teamA.trim() == event.teamB.trim()) {
      throw Exception('Team A and Team B cannot be the same');
    }

    if (!event.startTime.isBefore(event.endTime)) {
      throw Exception('Start time must be before end time');
    }

    if (event.title.trim().length < 3) {
      throw Exception('Title too short');
    }

    if (!['upcoming', 'live', 'ended'].contains(event.status)) {
      throw Exception('Invalid event status');
    }
  }

  /// -----------------------
  /// CREATE
  /// -----------------------

  Future<void> createLiveEvent({
    required LiveEvent event,
    required String adminUid,
  }) async {
    _validateEvent(event);

    await _ref.add({
      ...event.toFirestore(),
      'status': EventStatus.upcoming.value,
      'isVisible': true,
      'createdBy': adminUid,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// -----------------------
  /// UPDATE EVENT DETAILS
  /// -----------------------

  Future<void> updateLiveEvent({
    required String eventId,
    required LiveEvent event,
  }) async {
    _validateEvent(event);

    await _ref.doc(eventId).update({
      ...event.toFirestore(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// -----------------------
  /// UPDATE STATUS (STRICT FSM)
  /// -----------------------

  Future<void> updateEventStatus({
    required String eventId,
    required EventStatus newStatus,
  }) async {
    final doc = await _ref.doc(eventId).get();
    if (!doc.exists) throw Exception('Event not found');

    final currentStatus =
    EventStatusX.fromString(doc['status']);

    final bool allowed = switch (currentStatus) {
      EventStatus.upcoming =>
      newStatus == EventStatus.live ||
          newStatus == EventStatus.ended,
      EventStatus.live =>
      newStatus == EventStatus.ended,
      EventStatus.ended => false,
    };

    if (!allowed) {
      throw Exception(
        'Invalid status transition: '
            '${currentStatus.value} → ${newStatus.value}',
      );
    }

    await _ref.doc(eventId).update({
      'status': newStatus.value,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// -----------------------
  /// VISIBILITY TOGGLE
  /// -----------------------

  Future<void> toggleEventVisibility({
    required String eventId,
    required bool isVisible,
  }) async {
    await _ref.doc(eventId).update({
      'isVisible': isVisible,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
