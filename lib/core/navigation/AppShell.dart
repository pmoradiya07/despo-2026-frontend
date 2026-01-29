import 'package:despo/core/widgets/RetroNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/home_page.dart';
import '../../features/live_events/liveupdates_page.dart';
import '../../features/map/map_page.dart';
import '../../features/notifications/notifsscreen.dart';
import '../../features/profile/profilepage.dart';
import 'NavigationProvider.dart';


class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: [
          const HomeScreen(),
           MapScreen(),
          const LiveUpdates(),
          const NotifsScreen(),
          ProfileScreen(),
        ],
      ),

      // TEMPORARY placeholder nav bar
      bottomNavigationBar: RetroNavBar(
        currentIndex: currentTab,
        onTap: (index) =>
            ref.read(navigationProvider.notifier).setTab(index),
      ),
    );
  }
}
