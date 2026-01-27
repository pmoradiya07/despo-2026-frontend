import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile.dart';

class ApiService {
  static const String baseUrl =
      "https://script.google.com/macros/s/AKfycbyUjk7ZlUXXV7zBKvUKg_Qfty7KlY-1-Vmi6cF6SAU1_rrBbFyJ2sqWaVDCfczPhAPEFw/exec";

  static Future<Profile?> fetchProfile(String email) async {
    try {
      final url = Uri.parse('$baseUrl?email=$email');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data.containsKey('error')) return null;
        return Profile.fromApi(data);
      }
      return null;
    } catch (e) {
      print("API error: $e");
      return null;
    }
  }
}
