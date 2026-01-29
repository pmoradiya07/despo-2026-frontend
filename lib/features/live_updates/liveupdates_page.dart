
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveUpdates extends StatelessWidget {
  const LiveUpdates({super.key});

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
          Column(
            children: [
              SizedBox(height: 50.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  Expanded(child: PixelDashLine()),
                  SizedBox(width: 10.w),
                  Text(
                    "Live Updates",
                    style: GoogleFonts.jersey10(
                      fontSize: 25.sp,
                      color: Color.fromRGBO(255, 190, 38, 1),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(child: PixelDashLine()),
                  SizedBox(width: 20.w),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PixelDashLine extends StatelessWidget {
  const PixelDashLine({super.key});

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
              color: Colors.white70,
            ),
          ),
        );
      },
    );
  }
}
