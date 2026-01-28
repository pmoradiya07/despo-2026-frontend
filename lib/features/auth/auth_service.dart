import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // ------------------------
  // Riverpod Provider
  final authServiceProvider = Provider<AuthService>((ref) {
    return AuthService();
  });

  // ------------------------
  // Google Sign-In (UNCHANGED)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize();

      final GoogleSignInAccount? googleUser =
          await GoogleSignIn.instance.authenticate();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  // ------------------------
  // Sign Out
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }

  static const String profileApiUrl =
      "https://script.google.com/macros/s/AKfycbxhxW8bB8VGEtgGs21-NwrHe18iH5QrsV7dvXoxN_0xPEy99JZP_pq002TZYuLT3DGg/exec";

  Future<Map<String, dynamic>> fetchProfileByEmail(String email) async {
    try {
      final uri = Uri.parse("$profileApiUrl?email=$email");
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception("API failed: ${response.statusCode}");
      }

      final Map<String, dynamic> json =
          jsonDecode(response.body);

      if (json['status'] != 'ready') {
        throw Exception("Profile not found");
      }

      // 🔹 Return RAW values from sheet
      return {
        "name": json['name'] ?? '',
        "college": json['college'] ?? '',
        "mess": json['mess'] ?? 'No',
        "accommodation": json['accommodation'] ?? 'No',
        "pronite": json['pronite'] ?? 'No',
      };
    } catch (e) {
      print("Error fetching profile: $e");
      rethrow;
    }
  }
}
