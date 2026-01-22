import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation tabs (index contract)
/// 0 → Home
/// 1 → Map
/// 2 → Live
/// 3 → Notifications
/// 4 → Profile
class NavigationNotifier extends Notifier<int> {
  @override
  int build() {
    // Default tab: Home
    return 0;
  }

  /// Set tab by index (safe)
  void setTab(int index) {
    if (index < 0 || index > 4) return;
    if (state == index) return;
    state = index;
  }

  // Semantic navigation helpers
  void goHome() => setTab(0);
  void goMap() => setTab(1);
  void goLive() => setTab(2);
  void goNotifications() => setTab(3);
  void goProfile() => setTab(4);
}

/// Public provider
final navigationProvider =
NotifierProvider<NavigationNotifier, int>(NavigationNotifier.new);
