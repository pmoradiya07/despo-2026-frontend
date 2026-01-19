import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  final authServiceProvider = Provider<AuthService>((ref) {
    return AuthService();
  });

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Initialize Google Sign-In
      await GoogleSignIn.instance.initialize();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn.instance.authenticate();

      if (googleUser == null) {
        return null; // User cancelled
      }

      // Get auth details - this is a synchronous getter in v7.x
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

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

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }
}