import 'package:banner_widgets/banner/badge_painter.dart';
import 'package:banner_widgets/banner/badge_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BannerDecoration extends Decoration {
  final Color? color;
  final Size badgeSize;
  final Radius badgeCornerRadius;
  final BadgePosition badgePosition;

  const BannerDecoration.withColor({
    required Color this.color,
    required this.badgeSize,
    this.badgeCornerRadius = Radius.zero,
    this.badgePosition = BadgePosition.topEnd,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return BadgePainter(
        color: Colors.red,
        badgeSize: const Size(96.0, 96.0),
        badgeCornerRadius: const Radius.circular(0.0),
        badgePosition: badgePosition,
        baselineShift: 20.0,
        text: const TextSpan(
          text: "Beta",
          style: TextStyle(color: Colors.white),
        ));
  }
}
