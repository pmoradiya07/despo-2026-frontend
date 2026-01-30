import 'package:despo/core/widgets/RetroNavBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/home_page.dart';
import '../../features/live_events/liveupdates_page.dart';
import '../../features/map/map_page.dart';
import '../../features/notifications/notification_bridge_stub.dart' if (dart.library.io) '../../features/notifications/notification_bridge_mobile.dart';
import '../../features/notifications/notifsscreen.dart';
import '../../features/profile/profilepage.dart';
import '../../services/firebase_service.dart';
import 'NavigationProvider.dart';


class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final ProviderContainer _container;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _container = ProviderContainer();
    _init();
  }

  Future<void> _init() async {
    if (!kIsWeb) {
      NotificationsBridge.register(_container);
      await FirebaseService.init();
    }
    setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return UncontrolledProviderScope(
      container: _container,
      child: const _AppShellBody(),
    );
  }
}

class _AppShellBody extends ConsumerWidget {
  const _AppShellBody();

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
      bottomNavigationBar: RetroNavBar(
        currentIndex: currentTab,
        onTap: (index) =>
            ref.read(navigationProvider.notifier).setTab(index),
      ),
    );
  }
}


