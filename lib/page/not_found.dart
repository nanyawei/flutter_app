import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Center(
        child: Text('路径出错，找不到了...')
      ),
    );
  }
}