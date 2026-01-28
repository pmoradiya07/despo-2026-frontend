import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  void _openDirections(double lat, double lng) async {
    final uri = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng",
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showSports(
  BuildContext context,
  String venue,
  List<String> sports,
  double lat,
  double lng,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B0014), // dark retro base
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(
          color: const Color(0xFFFF4FA3), // neon pink
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.4),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Icon(Icons.sports_esports,
                  color: Color(0xFFFF4FA3)),
               SizedBox(width: 8),
              Text(
                venue.toUpperCase(),
                style: GoogleFonts.pressStart2p(
                  fontSize: 12,
                  color: Color.fromRGBO(165, 37, 83, 1),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sports.map((sport) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B0020),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Color.fromRGBO(165, 37, 83, 1),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  sport,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          /// 🚀 Directions Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(115, 19, 59, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 8,
                shadowColor: Color.fromRGBO(165, 37, 83, 1),
              ),
              onPressed: () => _openDirections(lat, lng),
              child: Text(
                "START NAVIGATION",
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

  /// Normalized positions (0–1 range)
  final List<Map<String, dynamic>> venues = [
    {
      "name": "Basketball Court",
      "x": 0.82,
      "y": 0.60,
      "color": Colors.red,
      "sports": ["Basketball", "Volleyball", "Lawn Tennis"],
      "lat": 26.9332228,
      "lng": 75.9225218,
    },
    {
      "name": "Ground",
      "x": 0.90,
      "y": 0.48,
      "color": Colors.red,
      "sports": ["Football", "Cricket"],
      "lat": 26.9309085,
      "lng": 75.9210756,
    },
    {
      "name": "SAC",
      "x": 0.78,
      "y": 0.50,
      "color": Colors.red,
      "sports": ["Badminton", "Squash", "Table Tennis", "Carrom", "Chess"],
      "lat": 26.9330068,
      "lng": 75.9229518,
    },
    {
      "name": "Academic Lawn",
      "x": 0.22,
      "y": 0.41,
      "color": Colors.red,
      "sports": ["Kabaddi"],
      "lat": 26.9351666,
      "lng": 75.9227061,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(165, 37, 83, 1),
                    Color.fromRGBO(115, 19, 59, 1),
                    Color.fromRGBO(79, 5, 42, 1),
                    Color.fromRGBO(18, 0, 20, 1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/shadowcover.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              "assets/images/Map.png",
              fit: BoxFit.contain,
            ),
          ),

          ...venues.map((v) {
            return Positioned(
              left: size.width * v["x"],
              top: size.height * v["y"],
              child: GestureDetector(
                onTap: () => _showSports(
                  context,
                  v["name"],
                  List<String>.from(v["sports"]),
                  v["lat"],
                  v["lng"],
                ),
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Icon(
                    Icons.location_pin,
                    size: 44,
                    color: v["color"],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
