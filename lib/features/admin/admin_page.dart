import 'package:despo/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPage extends StatelessWidget{
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminPageColors.adminPageBG,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/adminLive');
            },
            child: Image.asset('assets/images/liveEvents.png'),
          ),

          SizedBox(height: 30.h),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/adminNotifications');
            },

            child: Image.asset('assets/images/notifications.png'),
          )
        ],
      ),
    );
  }
}