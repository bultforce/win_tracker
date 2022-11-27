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
  Future<String?> getOpenUrl({required String browserName}) {
    // TODO: implement getOpenUrl
    throw UnimplementedError();
  }

  @override
  Future getOpenWindowTitle() {
    // TODO: implement getOpenWindowTitle
    throw UnimplementedError();
  }

  @override
  Future<bool?> getScreenSnapShot({required String fileName, required String filePath}) {
    // TODO: implement getScreenSnapShot
    throw UnimplementedError();
  }

  @override
  Future<bool?> isAccessAllowed() {
    // TODO: implement isAccessAllowed
    throw UnimplementedError();
  }

  @override
  Future<void> requestPermission({required bool onlyOpenPrefPane}) {
    // TODO: implement requestPermission
    throw UnimplementedError();
  }

  @override
  Stream streamKeyboardEventFromNative() {
    // TODO: implement streamKeyboardEventFromNative
    throw UnimplementedError();
  }

  @override
  Stream streamMouseEventFromNative() {
    // TODO: implement streamMouseEventFromNative
    throw UnimplementedError();
  }

}

void main() {
  final WinTrackerPlatform initialPlatform = WinTrackerPlatform.instance;

  test('$MethodChannelWinTracker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWinTracker>());
  });


}
