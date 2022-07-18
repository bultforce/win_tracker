
import 'dart:io';

import 'win_tracker_platform_interface.dart';

class WinTracker {

  Future<String?> getPlatformVersion() {
    return WinTrackerPlatform.instance.getPlatformVersion();
  }

  Future<String?> getScreenSnapShot({required String fileName, required String filePath}) async{
    if(Platform.isMacOS){
      var access = await isAccessAllowed();
      if(access !=null && access ){
        var data = await  WinTrackerPlatform.instance.getScreenSnapShot(fileName: fileName, filePath: filePath);
        return data.toString();
      }else{
        requestPermission();
        return "Permisson Required";
      }
    }
  }

  Stream<dynamic> streamKeyboardHook() {
    return WinTrackerPlatform.instance.streamKeyboardEventFromNative();
  }

  Stream<dynamic> streamMouseHook() {
    return WinTrackerPlatform.instance.streamMouseEventFromNative();
  }

  Future<void> requestPermission({ bool onlyOpenPrefPane = false}) {
    return WinTrackerPlatform.instance.requestPermission(onlyOpenPrefPane: onlyOpenPrefPane);
  }

  Future<bool?> isAccessAllowed() {
    return WinTrackerPlatform.instance.isAccessAllowed();
  }

}
