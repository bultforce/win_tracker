import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'win_tracker_method_channel.dart';

abstract class WinTrackerPlatform extends PlatformInterface {
  /// Constructs a WinTrackerPlatform.
  WinTrackerPlatform() : super(token: _token);

  static final Object _token = Object();

  static WinTrackerPlatform _instance = MethodChannelWinTracker();

  /// The default instance of [WinTrackerPlatform] to use.
  ///
  /// Defaults to [MethodChannelWinTracker].
  static WinTrackerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WinTrackerPlatform] when
  /// they register themselves.
  static set instance(WinTrackerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> getScreenSnapShot({required String fileName, required String filePath}) {
    throw UnimplementedError('screenSnapShot() has not been implemented.');
  }

  Stream<dynamic> streamMouseEventFromNative() {
    throw UnimplementedError('streamMouseEventFromNative() has not been implemented.');
  }
  Stream<dynamic> streamKeyboardEventFromNative() {
    throw UnimplementedError('streamKeyboardEventFromNative() has not been implemented.');
  }


  Future<void> requestPermission({required bool onlyOpenPrefPane}) {
    throw UnimplementedError('requestPermission() has not been implemented.');
  }

  Future<bool?> isAccessAllowed() {
    throw UnimplementedError('isAccessAllowed() has not been implemented.');
  }

  Future<String?> getOpenWindowTitle(){
    throw UnimplementedError('getOpenWindowTitle() has not been implemented.');
  }

  Future<String?> getOpenUrl(){
    throw UnimplementedError('getOpenUrl() has not been implemented.');
  }
}
