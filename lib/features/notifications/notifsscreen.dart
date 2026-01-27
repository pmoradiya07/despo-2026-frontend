import 'package:despo/core/constants/colors.dart';
import 'package:despo/core/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/fonts.dart';

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

  Future<void> _refresh() async {
    await ref.read(notificationsProvider.notifier).fetchNotifications();
  }

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
                  child: RefreshIndicator(
                    color: Colors.black,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20.h),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final n = state.notifications[index];
                        final isRead = state.readState[n.id] ?? false;
                        return NotificationBox(message: n.message, title: n.title, createdAt: n.createdAt,  isRead: isRead,
                            onTap: () {
                              ref.read(notificationsProvider.notifier).markAsRead(n.id);
                            }, location: '',
                        );
                      },
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

class NotificationBox extends StatelessWidget{
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;
  final String? location;
  final VoidCallback onTap;

  const NotificationBox({
    super.key,
    required this.message,
    required this.title,
    required this.createdAt,
    required this.location,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isRead
        ? NotificationPageColors.notificationRead
        : NotificationPageColors.notificationUnread;

    final messageStyle = isRead
        ? NotificationPageFonts.messageRead
        : NotificationPageFonts.messageUnread;

    final subtextStyle = isRead
        ? NotificationPageFonts.subtextRead
        : NotificationPageFonts.subtextUnread;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: NotificationPageColors.notificationBoxBorder,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // unread indicator
            if (!isRead)
              Container(
                width: 4,
                height: 48,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: NotificationPageColors.notificationBoxBorder,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

            // main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: NotificationPageFonts.title),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: messageStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (location != null) ...[
                    const SizedBox(height: 4),
                    Text(location!, style: subtextStyle),
                  ],
                ],
              ),
            ),

            // timestamp
            Text(
              _formatTime(createdAt),
              style: subtextStyle,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }





}
