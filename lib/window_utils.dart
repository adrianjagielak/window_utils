import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WindowUtils {
  static const MethodChannel _channel = const MethodChannel('window_utils');

  static Future showTitleBar() {
    return _channel.invokeMethod<bool>('showTitleBar');
  }

  static Future<bool> hideTitleBar() {
    return _channel.invokeMethod<bool>('hideTitleBar');
  }

  static Future<bool> setMoveable(bool canMove) {
    return _channel.invokeMethod<bool>('setMovable', {"canMove": canMove});
  }

  static Future<bool> startDrag() {
    return _channel.invokeMethod<bool>('startDrag');
  }

  static Future<int> childWindowsCount() {
    return _channel.invokeMethod<int>('childWindowsCount');
  }

  static Future<Size> getWindowSize() async {
    final _data = await _channel.invokeMethod<Map>('getWindowSize');
    return Size(_data['width'] as double, _data['height'] as double);
  }

  static Future<Offset> getWindowOffset() async {
    final _data = await _channel.invokeMethod<Map>('getWindowOffset');
    return Offset(_data['offsetX'] as double, _data['offsetY'] as double);
  }
}
