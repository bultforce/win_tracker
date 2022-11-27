import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'win_tracker_platform_interface.dart';

/// An implementation of [WinTrackerPlatform] that uses method channels.
class MethodChannelWinTracker extends WinTrackerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('win_tracker');
  @override
  Future<dynamic> getOpenWindowTitle() async{
    return await methodChannel.invokeMethod('getOpenWindowTitle');
  }
}
