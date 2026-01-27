import 'package:despo/features/admin/admin_page.dart';
import 'package:despo/features/auth/authGate.dart';
import 'package:despo/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/admin/LiveEventsScheduler.dart';
import 'features/admin/notifications_scheduler.dart';
import 'features/notifications/notification_bridge.dart';
import 'features/splash/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final ProviderContainer providerContainer = ProviderContainer();
  NotificationsBridge.register(providerContainer);
  await FirebaseService.init();

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const AppRoot(),
    ),
  );
}



class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800), // ANDROID-FIRST
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            '/auth': (_) => const AuthGate(),
            '/admin': (_) => const AdminPage(),
            '/adminLive': (_) => const LiveEventScheduler(),
            '/adminNotifications': (_) => const NotificationsScheduler(),
          },

        );
      },
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyApp> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyApp> {
// int selectedIndex = 0;
//
//   final List<Widget> screens =  [
//     const HomeScreen(),
//     const MapScreen(),
//     const LiveUpdates(),
//     const NotifsScreen(),
//     ProfileScreen(),
//   ];
//
//     final List<IconData> icons = const [
//     Icons.home,
//     Icons.map,
//     Icons.pin_drop,
//     Icons.notifications,
//     Icons.person,
//   ];
//
//   void onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[selectedIndex],
//       bottomNavigationBar: Container(
//         height: 100,
//         decoration: const BoxDecoration(
//           color: Colors.black,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(
//             icons.length,
//             (index) => InkWell(
//               onTap: () {
//                 setState(() {
//                   selectedIndex = index;
//                 });
//               },
//               child: Icon(
//                 icons[index],
//                 size: 28,
//                 color: selectedIndex == index
//                     ? Colors.white
//                     : Colors.grey,
//               ),
//             ),)
//         ),
//       ),
//     );
//   }
// }
