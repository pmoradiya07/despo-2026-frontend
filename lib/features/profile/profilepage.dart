import 'package:despo/features/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  final AuthService authService = AuthService();

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
                ProfileCardWidget(),
                SizedBox(height: 350.h),
                GestureDetector(
                  onTap: () async {
                    await authService.signOut();
                  },
                  child: Image.asset("assets/images/logout.png"),
                ),
                TextButton(
                  onPressed: () => showCallPopup(context),
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
            (index) => Container(
              width: dotSize,
              height: dotSize,
              color: color,
            ),
          ),
        );
      },
    );
  }
}

void showCallPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.black87,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.call, color: Colors.green),
              title: Text(
                'Abhas Chaudhary',
                style: GoogleFonts.jersey10(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              subtitle: Text(
                'Fest Head',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.call, color: Colors.green),
              title: Text(
                'Arnav Rinawa',
                style: GoogleFonts.jersey10(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              subtitle: Text(
                'Fest Head',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                // Navigator.pop(context);
                // makeCall('+919123456789');
              },
            ),
          ],
        ),
      );
    },
  );
}

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

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
                  Text("Panth Moradia", style: GoogleFonts.jersey10()),
                  SizedBox(width: 150.w, child: PixelDashLine(color: Colors.black,)),
                ],
              ),
              SizedBox(width: 20.h),
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
                  Text("LNMIIT", style: GoogleFonts.jersey10()),
                  SizedBox(width: 140.w, child: PixelDashLine(color: Colors.black,)),
                ],
              ),
              SizedBox(width: 20.h),
            ],
          ),
        ),
        Positioned(
          top: 60.h,
          left: 110.w,
          child: Row(
            children: [
              Text("Accomodation : ", style: GoogleFonts.jersey10()),
              Column(
                
                children: [
                  Text("YES", style: GoogleFonts.jersey10()),
                  SizedBox(width: 100.w, child: PixelDashLine(color: Colors.black,)),
                ],
              ),
              SizedBox(width: 20.h),
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
                  Text("NO", style: GoogleFonts.jersey10()),
                  SizedBox(width: 150.w, child: PixelDashLine(color: Colors.black,)),
                ],
              ),
              SizedBox(width: 20.h),
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
                  Text("YES", style: GoogleFonts.jersey10()),
                  SizedBox(width: 140.w, child: PixelDashLine(color: Colors.black,)),
                ],
              ),
              SizedBox(width: 20.h),
            ],
          ),
        ),
      ],
    );
  }
}
