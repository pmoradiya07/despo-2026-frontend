import 'package:flutter/material.dart';
import '../../services/live_admin_services.dart';

class LiveMatchesBlock extends StatelessWidget {
  final List<LiveEvent> events;

  const LiveMatchesBlock({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF7ED957), // green
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'LIVE\nMATCHES',
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
            child: Column(
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
