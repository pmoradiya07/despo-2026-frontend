import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(profile.email),
            const SizedBox(height: 8),

            buildChip("Accommodation", profile.accommodation),
            buildChip("Pronite", profile.pronite),
            buildChip("Mess", profile.mess),
          ],
        ),
      ),
    );
  }

  Widget buildChip(String label, bool included) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Chip(
        label: Text("$label: ${included ? "Included" : "Not Included"}"),
        backgroundColor: included ? Colors.green.shade100 : Colors.red.shade100,
      ),
    );
  }
}
