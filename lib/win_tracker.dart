
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

  Future<void> registerKeyboardHook() {
    return WinTrackerPlatform.instance.registerKeyboardHook();
  }

  Future<void> registerMouseHook() {
    return WinTrackerPlatform.instance.registerMouseHook();
  }

  Future<void> requestPermission({ bool onlyOpenPrefPane = false}) {
    return WinTrackerPlatform.instance.requestPermission(onlyOpenPrefPane: onlyOpenPrefPane);
  }

  Future<bool?> isAccessAllowed() {
    return WinTrackerPlatform.instance.isAccessAllowed();
  }

}
