import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/live_admin_services.dart';
import '../../core/widgets/event_card.dart';

class LiveMatchesBlock extends StatelessWidget {
  final List<LiveEvent> events;

  const LiveMatchesBlock({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Text(
        "No live matches",
        style: TextStyle(
          color: Colors.white54,
          fontSize: 13.sp,
        ),
      );
    }

    return Column(
      children: events.map((e) {
        return EventCard(
          teamA: e.teamA,
          teamB: e.teamB,
          venue: e.venue,
          timeText: "",
          isLive: true,
        );
      }).toList(),
    );
  }
}

