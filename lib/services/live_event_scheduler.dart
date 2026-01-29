import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminLiveEventService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api';

  static Future<void> createEvent({
    required String title,
    required String description,
    required DateTime eventAt,
    String? idToken,
  }) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/live-events'),
      headers: {
        'Content-Type': 'application/json',
        if (idToken != null) 'Authorization': 'Bearer $idToken',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'eventAt': eventAt.toIso8601String(),
      }),
    );

    if (res.statusCode != 201) {
      throw Exception(res.body);
    }
  }

  static Future<List<Map<String, dynamic>>> fetchEvents({
    String? idToken,
  }) async {
    final res = await http.get(
      Uri.parse('$_baseUrl/live-events'),
      headers: {
        if (idToken != null) 'Authorization': 'Bearer $idToken',
      },
    );

    if (res.statusCode != 200) {
      throw Exception(res.body);
    }

    final decoded = jsonDecode(res.body);
    return List<Map<String, dynamic>>.from(decoded['events']);
  }
}
