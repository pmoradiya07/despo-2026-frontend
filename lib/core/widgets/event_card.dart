import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final String teamA;
  final String teamB;
  final String venue;
  final String timeText;
  final bool isLive;

  const EventCard({
    super.key,
    required this.teamA,
    required this.teamB,
    required this.venue,
    required this.timeText,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0F1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isLive
              ? const Color(0xFF4CD964)
              : Colors.white24,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// STATUS ROW
          Row(
            children: [
              if (isLive) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CD964),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  "LIVE",
                  style: GoogleFonts.jersey10(
                    color: const Color(0xFF4CD964),
                    fontSize: 12.sp,
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.schedule,
                  size: 14.sp,
                  color: Colors.white60,
                ),
                SizedBox(width: 6.w),
                Text(
                  timeText,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 10.h),

          /// TEAMS
          Text(
            "$teamA  vs  $teamB",
            style: GoogleFonts.jersey10(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 6.h),

          /// VENUE
          Text(
            venue,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
