import 'dart:math';
import 'package:flutter/material.dart';
import './paint.dart';

typedef ProgressChanged<double> = void Function(double value);

class ProgressPainter extends StatefulWidget {
  final num multiple;
  final double level;
  final double dotRadius;
  final double shadowWidth;
  final Color shadowColor;
  final Color dotColor;
  final Color dotEdgeColor;
  final Color ringColor;
  final double radius;


  final ProgressChanged progressChanged;

  ProgressPainter({
    Key key,
    @required this.level,
    @required this.radius,
    @required this.dotRadius,
    this.dotColor = Colors.yellowAccent,
    this.shadowWidth = 2.0,
    this.shadowColor = Colors.black12,
    this.ringColor = Colors.black12,
    this.dotEdgeColor = Colors.yellowAccent,
    this.progressChanged,
    this.multiple
  }) : super(key: key);

  @override
  _ProgressPainterState createState () => _ProgressPainterState();
}

class _ProgressPainterState extends State<ProgressPainter> with SingleTickerProviderStateMixin {
  GlobalKey _gestureDetectorKey = GlobalKey();
  bool isValidTouch = false;
  bool isValidTouchCenter = false;

  AnimationController progressController;

  @override
  void initState () {
    super.initState();

    progressController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    if (widget.level != null) {
      progressController.value = (widget.level / widget.multiple).toDouble();
    }

    progressController.addListener(() {
      if (widget.progressChanged != null)
        widget.progressChanged(progressController.value * widget.multiple);
      setState(() {});
    });
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }

  void _onTap () {
    RenderBox getBox = _gestureDetectorKey.currentContext.findRenderObject();
    
    print( getBox.paintBounds.center );
    // Offset local = getBox.globalToLocal(details.globalPosition);
    // isValidTouchCenter = _checkTapCenter(local);
    // if (!isValidTouchCenter) {
    //   return;
    // }
    // print(details);
  }

  void _onPanStart(DragStartDetails details) {
    RenderBox getBox = _gestureDetectorKey.currentContext.findRenderObject();
    Offset local = getBox.globalToLocal(details.globalPosition);
    isValidTouch = _checkValidTouch(local);
    if (!isValidTouch) {
      return;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!isValidTouch) {
      return;
    }
    RenderBox getBox = _gestureDetectorKey.currentContext.findRenderObject();
    Offset local = getBox.globalToLocal(details.globalPosition);
    final double x = local.dx;
    final double y = local.dy;
    final double center = widget.radius;
    double radians = atan((x - center) / (center - y));
    if (y > center) {
      radians = radians + degToRad(180.0);
    } else if (x < center) {
      radians = radians + degToRad(360.0);
    }
    progressController.value = radians / degToRad(360.0);
  }

  void _onPanEnd(DragEndDetails details) {
    if (!isValidTouch) {
      return;
    }
  }
  bool _checkValidTouch(Offset pointer) {
    final double validInnerRadius = widget.radius - widget.dotRadius * 3;
    final double dx = pointer.dx;
    final double dy = pointer.dy;
    final double distanceToCenter =
        sqrt(pow(dx - widget.radius, 2) + pow(dy - widget.radius, 2));
    if (distanceToCenter < validInnerRadius ||
        distanceToCenter > widget.radius) {
      return false;
    }
    return true;
  }

  bool _checkTapCenter (Offset pointer) {
    // final double validCenterdx = widget.radius;
    // final double validCenterdy = widget.radius * 0.8;
    // final double centerRadius =  (widget.radius * 0.5 - widget.dotRadius) / 3;
    final double validInnerRadius = widget.radius * 0.8;

    final double dx = pointer.dx;
    final double dy = pointer.dy;
    final double distanceToCenter = sqrt(pow(dx - widget.radius, 2) + pow(dy - (widget.radius * 0.8), 2));
    if (distanceToCenter > validInnerRadius ||
        distanceToCenter > widget.radius) {
      return false;
    }
    return true;

  }



  @override
  Widget build(BuildContext context) {
    final double width = widget.radius * 2.0;
    final size = new Size(width, width);

    return GestureDetector(
      key: _gestureDetectorKey,
      onTap: () => _onTap(),
      onPanStart: (e) => _onPanStart(e),
      onPanUpdate: (e) => _onPanUpdate(e),
      onPanEnd: (e) => _onPanEnd(e),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: CustomPaint(
          size: size,
          painter: PaintProgress(
            dotRadius: widget.dotRadius,
            shadowWidth: widget.shadowWidth,
            shadowColor: widget.shadowColor,
            ringColor: widget.ringColor,
            dotColor: widget.dotColor,
            dotEdgeColor: widget.dotEdgeColor,
            progress: progressController.value,
          )
        ),
      )
    );
  }
}
