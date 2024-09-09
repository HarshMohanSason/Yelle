
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalLinesForSettingsButton extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow[700]!
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final double centerY = size.height / 2;

    // Drawing three lines with different lengths
    canvas.drawLine(
      Offset(size.width * 0.35, centerY - 10),
      Offset(size.width * 0.65, centerY - 10),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.25, centerY),
      Offset(size.width * 0.75, centerY),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.35, centerY + 10),
      Offset(size.width * 0.65, centerY + 10),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}