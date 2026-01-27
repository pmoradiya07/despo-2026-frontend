import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  void _call(String phone) {
    launchUrl(Uri.parse("tel:$phone"));
  }

  void _mail(String email) {
    launchUrl(Uri.parse("mailto:$email"));
  }

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
            child: Image.asset(
              'assets/images/shadowcover.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  /// HEADER
                  Row(
                    children: [
                      const Expanded(child: PixelDashLine()),
                      SizedBox(width: 10.w),
                      Text(
                        "Contact Us",
                        style: GoogleFonts.jersey10(
                          fontSize: 26.sp,
                          color: const Color.fromRGBO(255, 190, 38, 1),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      const Expanded(child: PixelDashLine()),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  /// FEST HEADS
                  _sectionTitle("Fest Heads"),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: ContactTile(
                          image: "assets/images/abhas.jpg",
                          name: "Abhas Chaudhary",
                          role: "Fest Head",
                          phone: "9411453707",
                          email: "23uec502@lnmiit.ac.in",
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ContactTile(
                          image: "assets/images/arnav.jpg",
                          name: "Arnav \nRinawa",
                          role: "Fest Head",
                          phone: "9166270181",
                          email: "23dec504@lnmiit.ac.in",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),

                  /// PR HEADS
                  _sectionTitle("PR Heads"),
                  SizedBox(height: 6.h),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 0.7,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    children: [
                      ContactTile(
                        image: "assets/images/hatim.jpg",
                        name: "Hatim Ali",
                        role: "PR Head",
                        phone: "7000244917",
                        email: "23ucs587@lnmiit.ac.in",
                      ),
                      ContactTile(
                        image: "assets/images/kartik.jpg",
                        name: "Kartik Singh",
                        role: "PR Head",
                        phone: "7651965230",
                        email: "23ucs611@lnmiit.ac.in",
                      ),
                      ContactTile(
                        image: "assets/images/kirti.jpg",
                        name: "Kirti Singhal",
                        role: "PR Head",
                        phone: "8279525359",
                        email: "23ucs619@lnmiit.ac.in",
                      ),
                      ContactTile(
                        image: "assets/images/sabhay.jpg",
                        name: "Sabhay Thakkar",
                        role: "PR Head",
                        phone: "9254475961",
                        email: "23ucc594@lnmiit.ac.in",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.jersey10(fontSize: 28.sp, color: Colors.white),
      ),
    );
  }
}

/// CONTACT TILE
class ContactTile extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  final String phone;
  final String email;

  const ContactTile({
    super.key,
    required this.image,
    required this.name,
    required this.role,
    required this.phone,
    required this.email,
  });

  void _call() => launchUrl(Uri.parse("tel:$phone"));
  void _mail() => launchUrl(Uri.parse("mailto:$email"));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 0, 35, 0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(255, 77, 166, 1), width: 2),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Container(
            width: 110.w,
            height: 110.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color:  Color.fromRGBO(255, 190, 38, 1),
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 10.h),
          Text(
            name,

            style: GoogleFonts.jersey10(
              fontSize: 20.sp,
              color: Colors.white,
              height: 0.95,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _call,
                child: Icon(Icons.call, size: 30, color: const Color.fromARGB(255, 233, 93, 158)),
              ),
              SizedBox(width: 20.2),
              GestureDetector(
                onTap: _mail,
                child: Icon(Icons.mail, size: 30, color: const Color.fromARGB(255, 233, 93, 158)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// PIXEL DASH
class PixelDashLine extends StatelessWidget {
  const PixelDashLine({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        const s = 2.0;
        final count = (c.maxWidth / (s * 2)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(width: s, height: s, color: Colors.white70),
          ),
        );
      },
    );
  }
}
