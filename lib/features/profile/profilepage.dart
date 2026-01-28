import 'package:despo/features/auth/auth_service.dart';
import 'package:despo/features/profile/contactus.dart';
import 'package:despo/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final User? user = authService.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          /// Background layers
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

          /// Content
          Center(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    Expanded(child: PixelDashLine(color: Colors.white70)),
                    SizedBox(width: 10.w),
                    Text(
                      "Profile",
                      style: GoogleFonts.jersey10(
                        fontSize: 25.sp,
                        color: Color.fromRGBO(255, 190, 38, 1),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(child: PixelDashLine(color: Colors.white70)),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(height: 20.h),

                /// Profile Card with live API
                if (user != null)
                  FutureBuilder<Map<String, dynamic>>(
                    future: authService.fetchProfileByEmail(user.email!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.white);
                      }
                      if (snapshot.hasError || !snapshot.hasData) {
                        return const Text(
                          "Failed to load profile",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      final data = snapshot.data!;

                      return ProfileCardWidget(
                        name: data['name'],
                        college: data['college'],
                        accommodation: data['accommodation'],
                        mess: data['mess'],
                        pronite: data['pronite'],
                      );
                    },
                  ),

                SizedBox(height: 30.h),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/admin');
                  },
                  child: Image.asset("assets/images/admin.png"),
                ),

                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () async {
                    await authService.signOut();
                  },
                  child: Image.asset("assets/images/logout.png"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Contact Us",
                    style: GoogleFonts.jersey10(
                      color: Colors.white,
                      fontSize: 20.sp,
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
}

/// Profile Card Widget
class ProfileCardWidget extends StatelessWidget {
  final String name;
  final String college;
  final bool accommodation;
  final bool mess;
  final bool pronite;

  const ProfileCardWidget({
    super.key,
    required this.name,
    required this.college,
    required this.accommodation,
    required this.mess,
    required this.pronite,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/profilecard.png",
          width: 320.w,
          fit: BoxFit.contain,
        ),

        Positioned(
          top: 10.h,
          left: 110.w,
          child: Row(
            children: [
              Text("Name : ", style: GoogleFonts.jersey10()),
              Column(
                children: [
                  Text(name, style: GoogleFonts.jersey10()),
                  SizedBox(
                    width: 150.w,
                    child: PixelDashLine(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          top: 35.h,
          left: 110.w,
          child: Row(
            children: [
              Text("College : ", style: GoogleFonts.jersey10()),
              Column(
                children: [
                  Text(college, style: GoogleFonts.jersey10()),
                  SizedBox(
                    width: 140.w,
                    child: PixelDashLine(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          top: 60.h,
          left: 110.w,
          child: Row(
            children: [
              Text("Accommodation : ", style: GoogleFonts.jersey10()),
              Column(
                children: [
                  Text(accommodation ? "YES" : "NO", style: GoogleFonts.jersey10()),
                  SizedBox(
                    width: 100.w,
                    child: PixelDashLine(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          top: 85.h,
          left: 110.w,
          child: Row(
            children: [
              Text("Mess : ", style: GoogleFonts.jersey10()),
              Column(
                children: [
                  Text(mess ? "YES" : "NO", style: GoogleFonts.jersey10()),
                  SizedBox(
                    width: 150.w,
                    child: PixelDashLine(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          top: 110.h,
          left: 110.w,
          child: Row(
            children: [
              Text("Pronite : ", style: GoogleFonts.jersey10()),
              Column(
                children: [
                  Text(pronite ? "YES" : "NO", style: GoogleFonts.jersey10()),
                  SizedBox(
                    width: 140.w,
                    child: PixelDashLine(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Pixel Dash Line
class PixelDashLine extends StatelessWidget {
  const PixelDashLine({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double dotSize = 1.0;
        const double spacing = 1.0;
        final int count = (constraints.maxWidth / (dotSize + spacing)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (index) => Container(width: dotSize, height: dotSize, color: color),
          ),
        );
      },
    );
  }
}
