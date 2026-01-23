import 'package:flutter/services.dart';

class HardwareButtons {
  static const MethodChannel _channel = MethodChannel("hardware_buttons");

  static void init({
    required VoidCallback onVolUpDown,
    required VoidCallback onVolUpUp,
    required VoidCallback onVolDownDown,
    required VoidCallback onVolDownUp,
  }) {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "volume_up_down":
          onVolUpDown();
          break;
        case "volume_up_up":
          onVolUpUp();
          break;
        case "volume_down_down":
          onVolDownDown();
          break;
        case "volume_down_up":
          onVolDownUp();
          break;
      }
    });
  }
}
