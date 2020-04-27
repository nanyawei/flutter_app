import 'dart:math';

import 'package:flutter/material.dart';

class PaintProgress extends CustomPainter {
  final double dotRadius;
  final double shadowWidth;
  final Color shadowColor;
  final Color dotColor;
  final Color dotEdgeColor;
  final Color ringColor;
  final double progress;
  final bool onTap;

  PaintProgress({
    this.dotRadius,
    this.shadowWidth = 2.0,
    this.shadowColor = Colors.black12,
    this.ringColor = const Color(0XFFF7F7FC),
    this.dotColor,
    this.dotEdgeColor = const Color(0XFFF5F5FA),
    this.progress,
    this.onTap = false
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width * 0.5;
    final Offset offsetCenter = Offset(center, center);
    final Offset offsetSwitchCenter = Offset(center, center* 0.8);

    final double drawRadius = size.width * 0.5 - dotRadius;

    final angle = 360.0 * progress;
    final double radians = degToRad(angle);

    final double radiusOffset = dotRadius * 0.4;
    final double outerRadius = center - radiusOffset;
    final double innerRadius = center - dotRadius * 2 + radiusOffset;

    // draw shadow.
    final shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = shadowColor
      ..strokeWidth = shadowWidth * 2
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowWidth);
    canvas.drawCircle(offsetCenter, outerRadius, shadowPaint);
    canvas.drawCircle(offsetCenter, innerRadius, shadowPaint);

    // Path path = Path.combine(
    //     PathOperation.difference,
    //     Path()
    //       ..addOval(Rect.fromCircle(center: offsetCenter, radius: outerRadius)),
    //     Path()
    //       ..addOval(
    //           Rect.fromCircle(center: offsetCenter, radius: innerRadius)));
    // canvas.drawShadow(path, shadowColor, 4.0, true);

    // draw ring.
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = ringColor
      ..strokeWidth = (outerRadius - innerRadius);
    canvas.drawCircle(offsetCenter, drawRadius, ringPaint);

    final Color currentDotColor = Color.alphaBlend(
        dotColor.withOpacity(0.7 + (0.3 * progress)), Colors.white);

    // draw progress.
    if (progress > 0.0) {
      final progressWidth = outerRadius - innerRadius + radiusOffset;
      final double offset = asin(progressWidth * 0.5 / drawRadius);
      if (radians > offset) {
        canvas.save();
        canvas.translate(0.0, size.width);
        canvas.rotate(degToRad(-90.0));
        print('radians: $radians');
        final Gradient gradient = new SweepGradient(
          endAngle: degToRad(360), // 整个圆环的亮度设置
          colors: [
            Colors.white,
            currentDotColor,
          ],
        );
        final Rect arcRect =
            Rect.fromCircle(center: offsetCenter, radius: drawRadius);
        final progressPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = progressWidth
          ..shader = gradient.createShader(arcRect);
        canvas.drawArc(arcRect, offset, radians - offset, false, progressPaint);
        canvas.restore();
      }
    }

    // draw dot.
    final double dx = center + drawRadius * sin(radians);
    final double dy = center - drawRadius * cos(radians);
    final dotPaint = Paint()..color = currentDotColor;
    canvas.drawCircle(new Offset(dx, dy), dotRadius, dotPaint);
    dotPaint
      ..color = dotEdgeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = dotRadius * 0.3;
    canvas.drawCircle(new Offset(dx, dy), dotRadius, dotPaint);

    final text = '% ' + (progress * 100).toInt().toString();

    TextPainter textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Times New Roman', fontSize: 14));
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(center - textPainter.width * 0.5,
            center * 1.2));




  final switchPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = ringColor
      ..strokeWidth = (outerRadius - innerRadius)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowWidth);
    canvas.drawCircle(offsetSwitchCenter, drawRadius/3, switchPaint);

  final switchInnerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = dotEdgeColor
      ..strokeWidth = 1;
    canvas.drawArc(Rect.fromCircle(center: offsetSwitchCenter, radius: 10), 150 , 190, false, switchInnerPaint);

    // canvas.drawLine(offsetSwitchCenter, offsetSwitchCenter, switchInnerPaint);






//    canvas.drawLine(
//        Offset(center, 0.0),
//        Offset(center, size.height),
//        Paint()
//          ..strokeWidth = 1.0
//          ..color = Colors.black);  // 测试基准线

    print('progress:::: ${(progress * 100).toInt()}');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

num degToRad(num deg) => deg * (pi / 180.0);
num radToDeg(num rad) => rad * (180.0 / pi);
