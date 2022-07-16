import 'package:flutter_test/flutter_test.dart';
import 'package:win_tracker/win_tracker.dart';
import 'package:win_tracker/win_tracker_platform_interface.dart';
import 'package:win_tracker/win_tracker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWinTrackerPlatform 
    with MockPlatformInterfaceMixin
    implements WinTrackerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getScreenSnapShot({required String fileName, required String filePath}) {
    // TODO: implement getScreenSnapShot
    throw UnimplementedError();
  }

  @override
  Future<void> registerKeyboardHook() {
    // TODO: implement registerKeyboardHook
    throw UnimplementedError();
  }

  @override
  Future<void> registerMouseHook() {
    // TODO: implement registerMouseHook
    throw UnimplementedError();
  }

  @override
  Future<bool?> requestPermission() {
    // TODO: implement requestPermission
    throw UnimplementedError();
  }
}

void main() {
  final WinTrackerPlatform initialPlatform = WinTrackerPlatform.instance;

  test('$MethodChannelWinTracker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWinTracker>());
  });

  test('getPlatformVersion', () async {
    WinTracker winTrackerPlugin = WinTracker();
    MockWinTrackerPlatform fakePlatform = MockWinTrackerPlatform();
    WinTrackerPlatform.instance = fakePlatform;
  
    expect(await winTrackerPlugin.getPlatformVersion(), '42');
  });
}
