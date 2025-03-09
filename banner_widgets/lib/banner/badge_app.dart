import 'package:banner_widgets/banner/badge_position.dart';
import 'package:banner_widgets/banner/banner_decoration.dart';
import 'package:flutter/material.dart';

class BadgeApp extends StatelessWidget {
  const BadgeApp({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BannerDecoration.withColor(
        color: Colors.red,
        badgeSize: const Size(100, 100),
        badgeCornerRadius: const Radius.circular(0.0),
        badgePosition: BadgePosition.topStart,
      ),
      child: child,
    );
  }
}
