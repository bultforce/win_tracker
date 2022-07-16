#ifndef FLUTTER_PLUGIN_WIN_TRACKER_PLUGIN_H_
#define FLUTTER_PLUGIN_WIN_TRACKER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace win_tracker {

class WinTrackerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WinTrackerPlugin();

  virtual ~WinTrackerPlugin();

  // Disallow copy and assign.
  WinTrackerPlugin(const WinTrackerPlugin&) = delete;
  WinTrackerPlugin& operator=(const WinTrackerPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace win_tracker

#endif  // FLUTTER_PLUGIN_WIN_TRACKER_PLUGIN_H_
