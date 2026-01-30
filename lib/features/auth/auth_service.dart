import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ------------------------
  // GOOGLE SIGN IN (ANDROID + WEB + iOS WEB)
  // Mobile sign-in (returns UserCredential)
  Future<UserCredential?> signInWithGoogleMobile() async {
  try {
    final GoogleAuthProvider provider = GoogleAuthProvider()
      ..addScope('email')
      ..addScope('profile');

    return await FirebaseAuth.instance.signInWithProvider(provider);
  } catch (e) {
    debugPrint("Mobile Google sign-in failed: $e");
    return null;
  }
}


  // Web sign-in (popup)
  Future<void> signInWithGoogleWeb() async {
    final GoogleAuthProvider provider = GoogleAuthProvider()
      ..addScope('email')
      ..addScope('profile');

    try {
      await _auth.signInWithPopup(provider);
    } catch (e) {
      debugPrint("Web Google sign-in failed: $e");
      rethrow;
    }
  }

  // Unified method for login
  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      await signInWithGoogleWeb();
    } else {
      await signInWithGoogleMobile();
    }
  }

  // Web only: handle redirect result
  Future<UserCredential?> handleWebRedirectResult() async {
    if (!kIsWeb) return null;

    try {
      return await _auth.getRedirectResult();
    } catch (e) {
      debugPrint("Redirect result error: $e");
      return null;
    }
  }

  // ------------------------
  // SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ------------------------
  // GOOGLE SHEET PROFILE FETCH
  static const String profileApiUrl =
      "https://script.google.com/macros/s/AKfycbxhxW8bB8VGEtgGs21-NwrHe18iH5QrsV7dvXoxN_0xPEy99JZP_pq002TZYuLT3DGg/exec";

  Future<Map<String, dynamic>> fetchProfileByEmail(String email) async {
    final uri = Uri.parse("$profileApiUrl?email=$email");
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Profile API error");
    }

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (json['status'] != 'ready') {
      throw Exception("Profile not found");
    }

    bool yesNo(String? v) =>
        v != null && v.trim().toLowerCase() == 'yes';

    return {
      "name": json['name'] ?? '',
      "college": json['college'] ?? '',
      "mess": yesNo(json['mess']),
      "accommodation": yesNo(json['accommodation']),
      "pronite": yesNo(json['pronite']),
    };
  }
}
