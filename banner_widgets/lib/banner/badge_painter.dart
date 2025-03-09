import 'package:banner_widgets/banner/badge_extentions.dart';
import 'package:banner_widgets/banner/badge_position.dart';
import 'package:flutter/material.dart';

class BadgePainter extends BoxPainter {
  final Size badgeSize;
  final Radius badgeCornerRadius;
  final BadgePosition badgePosition; // la posizione
  final double baselineShift;
  final Color? color;
  final TextSpan? text;

  const BadgePainter({
    required this.badgeSize,
    required this.badgeCornerRadius,
    this.badgePosition = BadgePosition.topStart,
    this.color,
    this.text,
    this.baselineShift = 0.0,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final size = cfg.size ?? const Size(0, 0);
    final clipRRect = RRect.fromLTRBR(
      offset.dx,
      offset.dy,
      offset.dx + size.width,
      offset.dy + size.height,
      badgeCornerRadius,
    );

    canvas.save();
    canvas.clipRRect(clipRRect);

    final shift = badgePosition.toPathOffset(
      globalOffset: offset,
      globalSize: size,
      badgeSize: badgeSize,
    );
    canvas.translate(shift.dx, shift.dy);

    final path = badgePosition.toBadgePath(badgeSize);

    final paint = Paint()
      ..color = color ?? Colors.yellow
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawPath(path, paint);
    if (text != null) {
      final textPainter = _createTextPainter();
      final textTranslate = badgePosition.toTextShift(
        textPainter,
        baselineShift,
      );

      final angle = badgePosition.toAngle(badgeSize);
      canvas.rotate(angle);

      canvas.translate(textTranslate.dx, textTranslate.dy);
      textPainter.paint(
        canvas,
        const Offset(0.5, 0.5),
      );
    }

    canvas.restore();
  }

  TextPainter _createTextPainter() {
    final hypo = calculateHypotenuse(badgeSize.width, badgeSize.height);
    return TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: hypo, maxWidth: hypo);
  }
}
