import 'package:flutter/material.dart';

class LifecycleManager extends WidgetsBindingObserver {
  static bool isBackground = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isBackground = state == AppLifecycleState.paused || state == AppLifecycleState.detached;
  }
}
