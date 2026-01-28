import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Replace these URLs with your GitHub images
  final List<String> galleryImages = [
    "https://raw.githubusercontent.com/USERNAME/REPO/main/images/1.jpg",
    "https://raw.githubusercontent.com/USERNAME/REPO/main/images/2.jpg",
    "https://raw.githubusercontent.com/USERNAME/REPO/main/images/3.jpg",
    "https://raw.githubusercontent.com/USERNAME/REPO/main/images/4.jpg",
  ];

  void _prevImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentIndex < galleryImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _openInstagram() async {
    final Uri url = Uri.parse('https://www.instagram.com/desportivos.lnmiit/?hl=en');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch Instagram';
    }
  }

  @override
  Widget build(BuildContext context) {
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Image.asset('assets/images/welcomedespo.png'),
                SizedBox(height: 20.h),

                /// About Us
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    Expanded(child: PixelDashLine()),
                    SizedBox(width: 10.w),
                    Text(
                      "About Us",
                      style: GoogleFonts.jersey10(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(255, 190, 38, 1),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(child: PixelDashLine()),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Text(
                    "Desportivos is The LNM Institute of Information Technology's (LNMIIT) flagship 3-day sports and esports entertainment festival. As Rajasthan's Largest Sports Fest, we bring together a unique blend of traditional sports like football, basketball, volleyball, and many more with modern gaming, creating an electrifying experience for a massive audience. Beyond the fields, the festival features pro-nights with live music concerts from famous artists such as Seedhe Maut and Darshan Raval, making Desportivos a comprehensive entertainment event.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.leagueSpartan(
                      color: Colors.white,
                      fontSize: 15.sp,
                      height: 1.25,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                GestureDetector(
                  onTap: _openInstagram,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF58529), // Insta orange
                          Color(0xFFDD2A7B), // Insta pink
                          Color(0xFF8134AF), // Insta purple
                          Color(0xFF515BD4), // Insta blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Follow us on Instagram",
                          style: GoogleFonts.leagueSpartan(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Image.asset("assets/images/insta.png", width: 30.w, height: 30.h,)
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                /// Gallery Header
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    Expanded(child: PixelDashLine()),
                    SizedBox(width: 10.w),
                    Text(
                      "Gallery",
                      style: GoogleFonts.jersey10(
                        fontSize: 25.sp,
                        color: const Color.fromRGBO(255, 190, 38, 1),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(child: PixelDashLine()),
                    SizedBox(width: 20.w),
                  ],
                ),
                SizedBox(height: 14.h),
                SizedBox(
                  height: 220.h,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: galleryImages.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pinkAccent.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(galleryImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      // Left arrow
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentIndex > 0) {
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black45,
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pinkAccent.withOpacity(0.6),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      // Right arrow
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentIndex < galleryImages.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black45,
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pinkAccent.withOpacity(0.6),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      // Dots indicator
                      Positioned(
                        bottom: 8.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            galleryImages.length,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.w),
                              width: _currentIndex == index ? 12.w : 6.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? Colors.pinkAccent
                                    : Colors.white38,
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pixel dash line for header
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
