import 'package:despo/features/admin/admin_page.dart';
import 'package:despo/features/auth/authGate.dart';
import 'package:despo/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/admin/LiveEventsScheduler.dart';
import 'features/admin/notifications_scheduler.dart';
import 'features/notifications/notification_bridge.dart';
import 'features/splash/splashScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ REQUIRED FOR iOS SAFARI GOOGLE SIGN-IN
  if (kIsWeb) {
    await FirebaseAuth.instance.getRedirectResult();
  }

  final providerContainer = ProviderContainer();
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
