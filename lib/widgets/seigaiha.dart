import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/palette.dart';

/// 青海波 — seigaiha, the overlapping-wave pattern found on Edo-period textiles.
///
/// Drawn rather than imported: concentric half-circles laid out in offset rows.
/// It sits at very low opacity behind the hero so it reads as texture in the
/// indigo, not as a graphic competing with the portrait.
class SeigaihaPainter extends CustomPainter {
  const SeigaihaPainter({
    this.color = Palette.washi,
    this.radius = 72,
    this.rings = 4,
    this.opacity = 0.055,
    this.strokeWidth = 1.1,
  });

  final Color color;
  final double radius;
  final int rings;
  final double opacity;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..color = color.withOpacity(opacity);

    // Rows overlap so each wave crests over the one below it.
    final rowHeight = radius * 0.52;
    final rowCount = (size.height / rowHeight).ceil() + 2;

    for (int row = 0; row < rowCount; row++) {
      final y = row * rowHeight;
      // Alternate rows shift by one radius, which is what makes the scales
      // interlock instead of stacking into columns.
      final shift = row.isEven ? 0.0 : radius;

      for (double x = -radius; x < size.width + radius * 2; x += radius * 2) {
        final centre = Offset(x + shift, y);
        for (int i = 1; i <= rings; i++) {
          final r = radius * i / rings;
          canvas.drawArc(
            Rect.fromCircle(center: centre, radius: r),
            math.pi, // start at 9 o'clock
            math.pi, // sweep across the top to 3 o'clock
            false,
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant SeigaihaPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.rings != rings ||
      old.opacity != opacity;
}

/// Convenience wrapper: the pattern, clipped to its box and ignored by hit
/// testing so it never steals a tap from the content in front of it.
class SeigaihaBackdrop extends StatelessWidget {
  const SeigaihaBackdrop({super.key, this.radius = 72, this.opacity = 0.055});

  final double radius;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRect(
        child: CustomPaint(
          painter: SeigaihaPainter(radius: radius, opacity: opacity),
          size: Size.infinite,
        ),
      ),
    );
  }
}
