import 'package:despo/features/home/home_page.dart';
import 'package:despo/features/live_updates/liveupdates_page.dart';
import 'package:despo/features/auth/login_page.dart';
import 'package:despo/features/map/map_page.dart';
import 'package:despo/features/notifications/notifspage.dart';
import 'package:despo/features/profile/profilepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800), // ANDROID-FIRST
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        );
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});
  final String title;

  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    MapScreen(),
    LiveUpdates(),
    NotifsScreen(),
    ProfileScreen(),
  ];

    final List<IconData> icons = const [
    Icons.home,
    Icons.map,
    Icons.pin_drop,
    Icons.notifications,
    Icons.person,
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Icon(
                icons[index],
                size: 28,
                color: selectedIndex == index
                    ? Colors.white
                    : Colors.grey,
              ),
            ),)
        ),
      ),
    );
  }
}
