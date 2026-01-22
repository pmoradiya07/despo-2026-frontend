import 'package:despo/core/constants/colors.dart';
import 'package:flutter/material.dart';

class NotificationPageFonts {
  static const TextStyle title = TextStyle(
    color: NotificationPageColors.notificationTitle,
    fontSize: 24,
    fontFamily: 'Jersey 10',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.96,
  );
  static const TextStyle messageRead = TextStyle(
    color: NotificationPageColors.notificationMessageRead,
    fontSize: 14.48,
    fontFamily: 'Jersey 10',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.96,
  );
  static const TextStyle messageUnread = TextStyle(
    color: NotificationPageColors.notificationMessageUnread,
    fontSize: 14.48,
    fontFamily: 'Jersey 10',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.96,
  );
  static const TextStyle subtextRead = TextStyle(
    color: NotificationPageColors.notificationSubtextRead,
    fontSize: 10,
    fontFamily: 'Jersey 10',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.96,
  );
  static const TextStyle subtextUnread = TextStyle(
    color: NotificationPageColors.notificationSubtextUnread,
    fontSize: 24,
    fontFamily: 'Jersey 10',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.96,
  );


}

class NavBarFonts {
  static const TextStyle navBarUnselected = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontFamily: 'Jersey 10',
    letterSpacing: 0.96,
  );
  static const TextStyle navBarSelected = TextStyle(
    color: NavbarColors.navBarSelectedText,
    fontSize: 15,
    fontFamily: 'Jersey 10',
    letterSpacing: 0.96,
  );
}