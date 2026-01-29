import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/live_events_providers.dart';
import '../widgets/live_matches_block.dart';
import '../widgets/upcoming_matches_block.dart';

class LiveUpdates extends ConsumerWidget {
  const LiveUpdates({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveEvents = ref.watch(liveEventsProvider);
    final upcomingEvents = ref.watch(upcomingEventsProvider);

    return Scaffold(
      body: Stack(
        children: [
          /// Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_image.png',
              fit: BoxFit.cover,
            ),
          ),

          /// Gradient overlay
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

          /// Shadow overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/shadowcover.png',
              fit: BoxFit.cover,
            ),
          ),

          /// CONTENT
          Column(
            children: [
              SizedBox(height: 50.h),

              /// HEADER
              Row(
                children: [
                  SizedBox(width: 20.w),
                  const Expanded(child: PixelDashLine()),
                  SizedBox(width: 10.w),
                  Text(
                    "Live Updates",
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

              SizedBox(height: 24.h),

              /// LIVE + UPCOMING BLOCKS
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      /// LIVE MATCHES
                      liveEvents.when(
                        data: (events) =>
                            LiveMatchesBlock(events: events),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, _) => Text(
                          e.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      /// UPCOMING MATCHES
                      upcomingEvents.when(
                        data: (events) =>
                            UpcomingMatchesBlock(events: events),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, _) => Text(
                          e.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
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
        final int count =
        (constraints.maxWidth / (dotSize + spacing)).floor();

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
