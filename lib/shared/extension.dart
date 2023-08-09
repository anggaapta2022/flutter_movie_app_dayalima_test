import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  double? get textscale {
    return MediaQuery.of(this).textScaleFactor > 0.9 ? 0.9 : null;
  }

  Future<dynamic> pop([bool? result]) async {
    return Navigator.of(this).pop(result);
  }

  Future<dynamic> push(Widget widget) async {
    return Navigator.of(this)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  Future<dynamic> pushAndRemoveUntil(Widget widget) async {
    return Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
