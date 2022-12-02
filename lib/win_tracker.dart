
import 'dart:io';

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

  }

}
}
