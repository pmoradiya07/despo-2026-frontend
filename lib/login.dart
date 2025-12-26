import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1️⃣ Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_image.png', // Your background image
              fit: BoxFit.cover,
            ),
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
                // Logo / torch icon
                const Icon(
                  Icons.wb_incandescent_rounded,
                  size: 80,
                  color: Colors.orangeAccent,
                ),
                const SizedBox(height: 30),

                // Login Card Container
                Container(
                  width: 300.w,
                  height: 350.h,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 195, 255, 1),
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
                            fontSize: 29.65.sp,
                            height: 0.65.h,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      _buildLabel("Email"),
                      _buildTextField("Enter your email"),
                      SizedBox(height: 5.h),
                      _buildLabel("Password"),
                      _buildTextField("Enter your password", isObscure: true),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.jersey10(
                            color: Color.fromRGBO(142, 0, 133, 1),
                            fontSize: 15.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            //  SIGN IN LOGIC HERE
                            debugPrint("Sign In clicked");
                          },
                          child: SizedBox(
                            width: 231.w,
                            height: 46.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  child: Image.asset(
                                    'assets/images/signin.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                Text(
                                  "SIGN IN",
                                  style: GoogleFonts.jersey10(
                                    fontSize: 22.sp,
                                    color: Colors.white,
                                    height: 1,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Social Login Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.circle,
                          color: Colors.grey[300],
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isObscure = false}) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
