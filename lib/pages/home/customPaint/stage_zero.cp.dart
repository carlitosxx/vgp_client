// import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class StageZeroCP extends StatelessWidget {
  const StageZeroCP(
      {super.key,
      required this.width,
      required this.colorBase,
      required this.colorShadow});
  final double width;
  final Color colorBase;
  final Color colorShadow;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(width, (width * 1).toDouble()),
        painter:
            RPSCustomPainter(colorBase: colorBase, colorShadow: colorShadow),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter({
    required this.colorBase,
    required this.colorShadow,
  });
  final Color colorBase;
  final Color colorShadow;
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.8937500);
    path_0.cubicTo(
        size.width * 0.2240596,
        size.height * 0.8937500,
        size.width * 0.0002524615,
        size.height * 0.6938750,
        0,
        size.height * 0.4473750);
    path_0.lineTo(0, size.height * 0.4473750);
    path_0.lineTo(0, size.height * 0.6016250);
    path_0.lineTo(0, size.height * 0.6016250);
    path_0.cubicTo(0, size.height * 0.6016250, 0, size.height * 0.6022500, 0,
        size.height * 0.6025000);
    path_0.cubicTo(0, size.height * 0.8220000, size.width * 0.2238071,
        size.height, size.width * 0.5000000, size.height);
    path_0.cubicTo(size.width * 0.7761929, size.height, size.width,
        size.height * 0.8220000, size.width, size.height * 0.6025000);
    path_0.cubicTo(size.width, size.height * 0.6022500, size.width,
        size.height * 0.6018750, size.width, size.height * 0.6016250);
    path_0.lineTo(size.width, size.height * 0.6016250);
    path_0.lineTo(size.width, size.height * 0.4473750);
    path_0.lineTo(size.width, size.height * 0.4473750);
    path_0.cubicTo(
        size.width * 0.9997475,
        size.height * 0.6940000,
        size.width * 0.7759404,
        size.height * 0.8937500,
        size.width * 0.5000000,
        size.height * 0.8937500);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = colorShadow;
    canvas.drawPath(path_0, paint0Fill);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = colorBase;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.5000000, size.height * 0.4468750),
            width: size.width,
            height: size.height * 0.8937500),
        paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
