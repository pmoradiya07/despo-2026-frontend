import 'dart:convert';
import 'package:despo/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // ------------------------
  // Provider for Riverpod
  final authServiceProvider = Provider<AuthService>((ref) {
    return AuthService();
  });

  // ------------------------
  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Initialize Google Sign-In
      await GoogleSignIn.instance.initialize();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn.instance.authenticate();

      if (googleUser == null) return null; // User cancelled

      // Get auth details
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
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

  // ------------------------
  // 🔥 Fetch profile by email from Google Sheet API
  static const String profileApiUrl =
      "https://script.google.com/macros/s/AKfycbyUjk7ZlUXXV7zBKvUKg_Qfty7KlY-1-Vmi6cF6SAU1_rrBbFyJ2sqWaVDCfczPhAPEFw/exec"; // Replace with your Apps Script URL

  Future<Map<String, dynamic>> fetchProfileByEmail(String email) async {
    try {
      final uri = Uri.parse("$profileApiUrl?email=$email");
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception("API request failed with status ${response.statusCode}");
      }

      final json = jsonDecode(response.body);

      if (json['error'] != null) {
        throw Exception(json['error']);
      }

      // Convert JSON to Profile model
      final profile = Profile.fromApi(json);

      return {
        "name": profile.name,
        "college": profile.college,
        "accommodation": profile.accommodation,
        "mess": profile.mess,
        "pronite": profile.pronite,
      };
    } catch (e) {
      print("Error fetching profile: $e");
      rethrow;
    }
  }
}
