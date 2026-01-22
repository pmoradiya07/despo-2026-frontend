import 'package:despo/core/constants/fonts.dart';
import 'package:flutter/material.dart';

class RetroNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;


  const RetroNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: Container(
          height: 88,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            children: List.generate(5, (index) {
              final isSelected = currentIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Center(
                    child: _buildNormalItem(index, isSelected),
                  ),
                ),
              );

            }),
          ),
        ),
      ),
    );
  }


  String _assetForIndex(int index, bool isSelected) {
    switch (index) {
      case 0:
        return isSelected
            ? 'assets/nav/home.png'
            : 'assets/nav/home_active.png';
      case 1:
        return isSelected
            ? 'assets/nav/map.png'
            : 'assets/nav/map_active.png';
      case 2:
        return isSelected
            ? 'assets/nav/live.png'
            : 'assets/nav/live_active.png';
      case 3:
        return isSelected
            ? 'assets/nav/notifs.png'
            : 'assets/nav/notifs_active.png';
      case 4:
        return isSelected
            ? 'assets/nav/profile.png'
            : 'assets/nav/profile_active.png';
      default:
        return '';
    }
  }


  String _labelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Map';
      case 2:
        return 'Live';
      case 3:
        return 'Alerts';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }

  Widget _buildNormalItem(int index, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          _assetForIndex(index, isSelected),
          width: 28,
          height: 28,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.none,
        ),
        ],
      ),
        const SizedBox(height: 4),
        Text(
          _labelForIndex(index),
          style: isSelected
            ? NavBarFonts.navBarSelected
              : NavBarFonts.navBarUnselected
        ),
      ],
    );
  }

}
