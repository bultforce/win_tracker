
import 'dart:io';

import 'package:win32/win32.dart';
import 'win_tracker_platform_interface.dart';
import 'dart:async';
import 'dart:io' show Platform, Directory;
import 'dart:ffi';
import 'dart:io';
import "package:ffi/ffi.dart";
import 'package:path/path.dart' as path;

typedef ReverseNative = Pointer<Utf8> Function();
typedef Reverse = Pointer<Utf8> Function();
class WinTracker {

  String? windowTitle;
  int i =0;
  Future<dynamic> getOpenWindowTitle({String? libPath})async{
    if(Platform.isMacOS){
      var windows = await WinTrackerPlatform.instance.getOpenWindowTitle();
      return windows;
    }else if(Platform.isLinux){
      if(libPath==null){
        return "Please enter your lib path";
      }else{
       try{
         var libraryPath =
         path.join(libPath, 'win_library', 'libwin.so');

         final dylib = DynamicLibrary.open(libraryPath);

         // Look up the C function 'hello_world'
         final reverse = dylib.lookupFunction<ReverseNative, Reverse>('win_track');
         final reversedMessageUtf8 = reverse();
         final reversedMessage = reversedMessageUtf8.toDartString();
         return reversedMessage;
       }catch (e){
         return "None";
       }
    }

  }else if(Platform.isWindows){
     return enumerateWindows();
    }

}
  String? enumerateWindows() {
    final hWnd= GetForegroundWindow();
    if (IsWindowVisible(hWnd) == FALSE) return null;
    final length = GetWindowTextLength(hWnd);
    if (length == 0) {
      return null;
    }
    final buffer = wsalloc(length + 1);
    GetWindowText(hWnd, buffer, length + 1);
    String windowTitle = buffer.toDartString();
    free(buffer);
    return windowTitle;
  }
}
