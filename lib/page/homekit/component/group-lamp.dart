import 'package:flutter/material.dart';
import 'package:flutter_console/component/progress-painter/index.dart';
import 'package:flutter_console/model/homekit.dart';

Widget groupLamp (GroupLampModel groupLamp) {
  return  Container(
      child: ProgressPainter(
      level: groupLamp.level.toDouble(),
      multiple: 255,
      radius: 75,
      dotRadius: 20/2,
      dotColor: Colors.yellowAccent,
      progressChanged: (v) {
        // print('vvv: $v');
      },
    )
  );
}