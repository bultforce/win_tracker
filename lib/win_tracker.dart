
import 'dart:io';

import 'win_tracker_platform_interface.dart';

class WinTracker {

  Future<dynamic> getOpenWindowTitle()async{
    var windows = await WinTrackerPlatform.instance.getOpenWindowTitle();
    return windows;
  }

}
