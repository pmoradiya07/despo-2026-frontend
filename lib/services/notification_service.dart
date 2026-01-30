import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminNotificationService {
  static const String _baseUrl = 'http://localhost:3000/api'; //PANTH ISKO CHANGE KARNA

  static Future<void> sendNotification({
    required String title,
    required String body,
    String? idToken, // null in DEV_MODE
  }) async {
    final uri = Uri.parse('$_baseUrl/notifications');

    final headers = {
      'Content-Type': 'application/json',
      if (idToken != null) 'Authorization': 'Bearer $idToken',
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'Failed to send notification: ${response.body}',
      );
    }
  }

  static Future<List<Map<String, dynamic>>> fetchNotifications({
    String? idToken,
  }) async {
    final uri = Uri.parse('$_baseUrl/notifications');

    final headers = {
      if (idToken != null) 'Authorization': 'Bearer $idToken',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch notifications: ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(decoded['notifications']);
  }
}
