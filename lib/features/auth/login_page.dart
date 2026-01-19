import 'package:despo/features/auth/auth_service.dart';
import 'package:despo/features/home/home_page.dart';
import 'package:despo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  final AuthService _authService = AuthService();
  bool _isLoading = false;

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
                    color: Color.fromRGBO(255, 195, 255, 1),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
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
                      // SizedBox(height: 5.h),
                      // _buildLabel("Email"),
                      // _buildTextField("Enter your email"),
                      // SizedBox(height: 5.h),
                      // _buildLabel("Password"),
                      // _buildTextField("Enter your password", isObscure: true),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     "Forgot Password?",
                      //     style: GoogleFonts.jersey10(
                      //       color: Color.fromRGBO(142, 0, 133, 1),
                      //       fontSize: 15.sp,
                      //       decoration: TextDecoration.underline,
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        height: 20.h,
                      ),

                      Center(
                        child: GestureDetector(
                          onTap: _isLoading ? null : () async {
                            setState(() {
                              _isLoading = true;
                            });
                            debugPrint("Sign In Clicked");

                            try {
                              final userCredential = await _authService.signInWithGoogle();

                              if(userCredential != null && mounted){
                                Navigator.pushReplacement(context, 
                                MaterialPageRoute(builder: (context) => MyApp(title: '')));

                                debugPrint("Sign in successful: ${userCredential.user?.email}");
                              } else {
                                debugPrint("Sign in Cancelled");
                              }

                            }
                            catch (e) {
                              debugPrint("Sign in error $e");
                              if (mounted){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:
                                  Text("Failed to Sign-In, Please Try Again"),
                                    backgroundColor: Colors.red,
                                  )
                                );
                              }
                            }
                            finally {
                              if(mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
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
                                      //top: ,
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

                SizedBox(height: 30.h),

                // Social Login Icons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: List.generate(
                //     3,
                //     (index) => Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       child: CircleAvatar(
                //         radius: 20,
                //         backgroundColor: Colors.white,
                //         child: Icon(
                //           Icons.circle,
                //           color: Colors.grey[300],
                //           size: 20,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isObscure = false}) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey, fontSize: 9.sp),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
