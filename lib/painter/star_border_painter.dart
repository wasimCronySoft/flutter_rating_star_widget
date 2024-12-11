// Custom painter to draw the border for the star shape
import 'package:flutter/material.dart';
import '../clipper/star_clipper.dart';

// Custom painter to draw the border of the star
class StarBorderPainter extends CustomPainter {
  final Color borderColor;

  StarBorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the star's border using the custom clipper's star shape
    final path = StarClipper().getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
