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

  factory Profile.fromApi(Map<String, dynamic> json) {
    print("🟡 FULL API JSON: $json");

    String rawCollege = json['college'] ?? "";
    print("🟢 College from API: '$rawCollege'");

    String normalizedCollege = rawCollege.trim().toLowerCase();
    print("🔵 Normalized college: '$normalizedCollege'");

    final rules = collegeRules[normalizedCollege];
    print("🟣 Rules found: ${rules != null}");

    return Profile(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      college: rawCollege,
      accommodation: rules?.accommodation ?? false,
      pronite: rules?.pronite ?? false,
      mess: rules?.mess ?? false,
    );
  }
}
