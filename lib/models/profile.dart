import 'dart:convert';
import 'college.dart';

class Profile {
  final String name;
  final String email;
  final String college;
  final bool accommodation;
  final bool pronite;
  final bool mess;

  Profile({
    required this.name,
    required this.email,
    required this.college,
    required this.accommodation,
    required this.pronite,
    required this.mess,
  });

  // Build Profile using API response + Flutter rules
  factory Profile.fromApi(Map<String, dynamic> json) {
    String college = json['college'] ?? "";

    // Get rules for this college
    final rules = collegeRules[college] ?? CollegeRules();

    return Profile(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      college: college,
      accommodation: rules.accommodation,
      pronite: rules.pronite,
      mess: rules.mess,
    );
  }
}
