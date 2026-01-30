import 'package:despo/core/navigation/AppShell.dart';
import 'package:despo/features/auth/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Handle Web redirect result if user returns from Google login
    // if (kIsWeb) _handleWebRedirect();
  }

  // Future<void> _handleWebRedirect() async {
   // final userCredential = await _authService.handleWebRedirectResult();
  //   if (userCredential?.user != null && mounted) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const AppShell()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg_image.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(165, 37, 83, 1),
                      Color.fromRGBO(115, 19, 59, 1),
                      Color.fromRGBO(79, 5, 42, 1),
                      Color.fromRGBO(18, 0, 20, 1),
                    ],
                    stops: [0.02, 0.23, 0.45, 0.60],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                'assets/images/shadowcover.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/despo_logo.svg'),
                SizedBox(height: 30.h),
                Container(
                  width: 300.w,
                  height: 190.h,
                  padding: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 195, 255, 1),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Welcome To\nDesportivos",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.jersey10(
                            fontSize: 35.sp,
                            height: 0.65.h,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: GestureDetector(
                          onTap: _isLoading
                              ? null
                              : () async {
                            setState(() => _isLoading = true);
                            try {
                              if (kIsWeb) {
                                // Web: redirect-based sign-in
                                await _authService.signInWithGoogle();
                                return; // execution ends due to redirect
                              } else {
                                // Mobile: native sign-in
                                await _authService.signInWithGoogleMobile();
                                // ❌ NO navigation here
                                // AuthGate will rebuild automatically
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Google sign-in failed: $e"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _isLoading = false);
                            }
                          },
                          child: SizedBox(
                            width: 225.w,
                            height: 46.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      right: 22,
                                      child: Image.asset(
                                        'assets/images/outsignin.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                      right: 25,
                                      top: 2,
                                      child: Image.asset(
                                        'assets/images/signin.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                if (_isLoading)
                                  const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                else
                                  Positioned(
                                    top: 10,
                                    child: Text(
                                      "Sign In",
                                      style: GoogleFonts.jersey10(
                                        fontSize: 22.sp,
                                        color: Colors.white,
                                        height: 1,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                      ),
                      Center(
                        child: Text(
                          "Use the Google Account you registered with",
                          style: GoogleFonts.jersey10(
                            color: Colors.purple,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
