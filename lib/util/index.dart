import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// base64库
import 'dart:convert' as convert;
// 文件相关
import 'dart:io';

class Util {
/*
  * Base64加密
  */
  static String base64Encode(String data) {
    var content = convert.utf8.encode(data);
    var digest = convert.base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String base64Decode(String data) {
    List<int> bytes = convert.base64Decode(data);
    // 网上找的很多都是String.fromCharCodes，这个中文会乱码
    //String txt1 = String.fromCharCodes(bytes);
    String result = convert.utf8.decode(bytes);
    return result;
  }

  /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future image2Base64(String path) async {
    File file = new File(path);
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }

  /*
  * 将图片文件转换成Base64字符串
  */
  static Future imageFile2Base64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return convert.base64Encode(imageBytes);
  }

  /*
  * 将Base64字符串的图片转换成图片
  */
  static Future<Image> base642Image(String base64Txt) async {
    Uint8List decodeTxt = convert.base64.decode(base64Txt);
    return Image.memory(
      decodeTxt,
      width: 100, fit: BoxFit.fitWidth,
      gaplessPlayback: true, //防止重绘
    );
  }
}

// 1度对应的弧度
final double rad = pi / 180.0;

// 绘制工具
class PainterUtil {
  // 绘制线段
  static void paintLine(Canvas canvas, double startX, double endX,
      {Offset center = const Offset(0, 0),
      Color color = Colors.red,
      double rotateAngle = 0,
      double strokeWidth = 1}) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotateAngle * rad);
    canvas.drawLine(
        Offset(startX, 0),
        Offset(endX, 0),
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth);
    canvas.restore();
  }

  // 绘制标题
  static void paintString(Canvas canvas, Offset point, String text,
      {double fontSize = 12, Color color, double rotateAngle = 0}) {
    TextPainter textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.rtl);

    textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
            color: color, fontFamily: 'Times New Roman', fontSize: fontSize));
    textPainter.layout();
    canvas.save();
    canvas.rotate(-rotateAngle);
    textPainter.paint(
        canvas,
        Offset(point.dx - textPainter.width * 0.5,
            point.dy - textPainter.height * 0.5));
    canvas.restore();
  }

  // 绘制圆弧
  static void paintArc(Canvas canvas, Offset center, double radius,
      {double startAngle = 0.0,
      double sweepAngle = 360.0,
      Color color = Colors.blue,
      double strokeWidth = 1,
      PaintingStyle paintingStyle = PaintingStyle.stroke}) {
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
        rect,
        startAngle * rad,
        sweepAngle * rad,
        false,
        Paint()
          ..color = color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth
          ..style = paintingStyle);
  }
}
