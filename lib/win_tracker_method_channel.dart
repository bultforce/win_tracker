import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'win_tracker_platform_interface.dart';

/// An implementation of [WinTrackerPlatform] that uses method channels.
class MethodChannelWinTracker extends WinTrackerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('win_tracker');

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
  Future<void> registerKeyboardHook() async{
    return await methodChannel.invokeMethod('registerKeyboardHook',);
  }
  @override
  Future<void> registerMouseHook() async{
    return await methodChannel.invokeMethod('registerMouseHook',);
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

}
