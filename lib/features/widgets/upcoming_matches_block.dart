import 'package:flutter/material.dart';
import '../../services/live_admin_services.dart';

class UpcomingMatchesBlock extends StatelessWidget {
  final List<LiveEvent> events;

  const UpcomingMatchesBlock({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B6B), // red
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'UPCOMING\nMATCHES',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(12),
            child: events.isEmpty
                ? const Text('No upcoming matches')
                : Column(
              children: events.map(_eventRow).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventRow(LiveEvent event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        '• ${event.teamA} vs ${event.teamB} @ ${event.venue}',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
