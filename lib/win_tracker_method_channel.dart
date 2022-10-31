import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'win_tracker_platform_interface.dart';

/// An implementation of [WinTrackerPlatform] that uses method channels.
class MethodChannelWinTracker extends WinTrackerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('win_tracker');
  var keyBoardEventChannel = const EventChannel('win_tracker_keyboard');
  var mouseEventChannel = const EventChannel('win_tracker_mouse');
  late StreamSubscription<dynamic> keyBoardSubscription;
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }


  @override
  Future<bool?> getScreenSnapShot({required String fileName, required String filePath}) async{
    var optionMap = <String, String?>{};
    optionMap.putIfAbsent("fileName", () => fileName );
    optionMap.putIfAbsent("filePath", () => filePath);
    return await methodChannel.invokeMethod('screenCapture', optionMap);
  }

  @override
  Stream<dynamic> streamKeyboardEventFromNative() {
    return keyBoardEventChannel.receiveBroadcastStream("keyBoard_event").map((event) => event);
  }

  @override
  Stream<dynamic> streamMouseEventFromNative() {
    return mouseEventChannel.receiveBroadcastStream("mouse_event").map((event) {
      return event;
    });
  }
  @override
  Future<void> requestPermission({required bool onlyOpenPrefPane}) async{
    if (!kIsWeb && Platform.isMacOS) {
      final Map<String, dynamic> arguments = {
        'onlyOpenPrefPane': onlyOpenPrefPane,
      };
      await methodChannel.invokeMethod('requestPermission', arguments);
    }
  }

  @override
  Future<bool?> isAccessAllowed() async{
    return await methodChannel.invokeMethod('isAccessAllowed',);
  }

  @override
  Future<String?> getOpenUrl({required String browserName}) async{
    var optionMap = <String, String?>{};
    optionMap.putIfAbsent("browserName", () => browserName );
    return await methodChannel.invokeMethod('getOpenUrl',optionMap);
  }
  @override
  Future<dynamic> getOpenWindowTitle() async{
    return await methodChannel.invokeMethod('getOpenWindowTitle');
  }
}
