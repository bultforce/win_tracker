import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:win_tracker/win_tracker_method_channel.dart';

void main() {
  MethodChannelWinTracker platform = MethodChannelWinTracker();
  const MethodChannel channel = MethodChannel('win_tracker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
