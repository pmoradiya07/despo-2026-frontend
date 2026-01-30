import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/live_admin_services.dart';
import '../../core/widgets/event_card.dart';

class UpcomingMatchesBlock extends StatelessWidget {
  final List<LiveEvent> events;

  const UpcomingMatchesBlock({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Text(
        "No upcoming matches",
        style: TextStyle(
          color: Colors.white54,
          fontSize: 13.sp,
        ),
      );
    }

    return Column(
      children: events.map((e) {
        final time =
            "${e.startTime.hour.toString().padLeft(2, '0')}:${e.startTime.minute.toString().padLeft(2, '0')}";

        return EventCard(
          teamA: e.teamA,
          teamB: e.teamB,
          venue: e.venue,
          timeText: time,
          isLive: false,
        );
      }).toList(),
    );
  }
}

