import 'package:despo/core/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifsScreen extends ConsumerStatefulWidget {
  const NotifsScreen({super.key});

  @override
  ConsumerState<NotifsScreen> createState() => _NotifsScreenState();
}
//TODO Live updates (Firestore snapshots() stream)

//TODO FCM push → Firestore sync

// TODO Mark read / unread

// TODO Offline caching

class _NotifsScreenState extends ConsumerState<NotifsScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger load ONCE
    Future.microtask(() {
      ref.read(notificationsProvider.notifier).fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationsProvider);

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
          Column(
            children: [
              SizedBox(height: 50.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  const Expanded(child: PixelDashLine()),
                  SizedBox(width: 10.w),
                  Text(
                    "Notifications",
                    style: GoogleFonts.jersey10(
                      fontSize: 25.sp,
                      color: const Color.fromRGBO(255, 190, 38, 1),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  const Expanded(child: PixelDashLine()),
                  SizedBox(width: 20.w),
                ],
              ),

              // 🔵 LOADING STATE
              if (state.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              // 🔴 ERROR STATE
              else if (state.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              // 🟢 DATA STATE
              else
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 20.h),
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final n = state.notifications[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            n.title,
                            style: GoogleFonts.jersey10(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            n.message,
                            style: GoogleFonts.jersey10(
                              fontSize: 14.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      )

                      );
                    },
                  ),
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
